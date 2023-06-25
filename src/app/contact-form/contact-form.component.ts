import { animate, style, transition, trigger } from '@angular/animations';
import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormsModule, NgForm } from '@angular/forms';
import { DialogComponent } from '../dialog/dialog.component';

@Component({
  selector: 'app-contact-form',
  templateUrl: './contact-form.component.html',
  animations: [
    trigger('alertSlide', [
      transition(':enter', [
        style({ height: '0px', opacity: 0 }),
        animate('200ms ease', style({ height: '0.5rem', opacity: 1 })),
      ]),
      transition(':leave', [
        style({ height: '0.5rem', opacity: 1 }),
        animate('200ms ease', style({ height: '0px', opacity: 0 })),
      ]),
    ]),

    trigger('loadingSlide', [
      transition(':enter', [
        style({ width: 0, opacity: 0 }),
        animate('200ms ease', style({ width: '2.5rem', opacity: 1 })),
      ]),
      transition(':leave', [
        style({ width: '2.5rem', opacity: 1 }),
        animate('200ms ease', style({ width: 0, opacity: 0 })),
      ]),
    ]),
  ],
  styleUrls: ['./contact-form.component.scss'],
  imports: [DialogComponent, CommonModule, FormsModule],
  standalone: true,
})
export class ContactFormComponent {
  loading = false;
  success = false;
  error = false;

  closeDialog() {
    this.success = false;
    this.error = false;
  }

  async onSubmit(form: NgForm) {
    if (this.loading) return;

    if (!form.controls['message'].valid) {
      document.getElementById('message')?.focus();
    }
    if (!form.controls['email'].valid) {
      document.getElementById('email')?.focus();
    }
    if (!form.controls['name'].valid) {
      document.getElementById('name')?.focus();
      form.controls['name'].markAsDirty();
      form.controls['name'].markAsTouched();
    }
    if (!form.valid) {
      document.getElementById('submit')?.classList.add('error');
      setTimeout(() => {
        document.getElementById('submit')?.classList.remove('error');
      }, 500);

      return;
    }

    this.loading = true;

    /* function endpoint https://uynr3m7gfcirffdr45lwiqpfsq0ptjos.lambda-url.us-east-1.on.aws/
     *
     * takes a json body with the following properties:
     * { name: string, email: string, message: string }
     *
     * validates input and sends email to me
     *
     * returns 200 if successful
     * returns 500 if unsuccessful
     */

    await fetch(
      'https://uynr3m7gfcirffdr45lwiqpfsq0ptjos.lambda-url.us-east-1.on.aws/',
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(this.contact),
      }
    )
      .then(async (response) => {
        console.log(response);
        if (response.status === 200) {
          this.success = true;
        } else {
          this.error = true;
        }
      })
      .catch((error) => {
        console.log(error);
        this.error = true;
      });

    form.resetForm();
    this.loading = false;
  }

  contact = {
    name: 'asdfaf',
    email: 'asdf@lsjdfsd.sdfsf',
    message: 'asdfadfasdfasdf',
  };
}
