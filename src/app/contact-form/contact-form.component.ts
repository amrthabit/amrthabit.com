import { Component } from '@angular/core';
import {
  trigger,
  style,
  animate,
  transition,
  state,
} from '@angular/animations';
import { FormControl, Validators, FormGroup } from '@angular/forms';
import { NgForm } from '@angular/forms';

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
})
export class ContactFormComponent {
  loading = false;
  success = false;
  error = false;

  async onSubmit(form: NgForm) {
    if (this.loading) return;

    if (!form.controls['message'].valid) {
      console.log('Message is not valid');
      document.getElementById('message')?.focus();
    }
    if (!form.controls['email'].valid) {
      console.log('Email is not valid');
      document.getElementById('email')?.focus();
    }
    if (!form.controls['name'].valid) {
      console.log('Name is not valid');
      document.getElementById('name')?.focus();
      form.controls['name'].markAsDirty();
      form.controls['name'].markAsTouched();
    }
    if (!form.valid) {
      document.getElementById('submit')?.classList.add('error');
      setTimeout(() => {
        document.getElementById('submit')?.classList.remove('error');
      }, 500);

      console.log('Form is not valid');
      return;
    }

    this.loading = true;
    // function endpoints https://uynr3m7gfcirffdr45lwiqpfsq0ptjos.lambda-url.us-east-1.on.aws/

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

    setTimeout(() => {
      this.loading = false;
    }, 2000);
  }

  contact = {
    name: 'asdfaf',
    email: 'asdf@lsjdfsd.sdfsf',
    message: 'asdfadfasdfasdf',
  };
}
