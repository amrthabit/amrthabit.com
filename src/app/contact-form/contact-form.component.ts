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

  private tryVibrate(pattern: number[]) {
    // Only try to vibrate if the API exists
    if ('vibrate' in navigator) {
      navigator.vibrate(pattern);
    }
  }

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
      this.tryVibrate([5, 100, 5]);  // Form validation error vibration
      document.getElementById('submit')?.classList.add('error');
      setTimeout(() => {
        document.getElementById('submit')?.classList.remove('error');
      }, 500);
      return;
    }

    this.loading = true;

    try {
      const response = await fetch(
        'https://uynr3m7gfcirffdr45lwiqpfsq0ptjos.lambda-url.us-east-1.on.aws/',
        {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(this.contact),
        }
      );

      if (response.status === 200) {
        this.success = true;
        this.tryVibrate([50, 50, 100]); // Success vibration
      } else {
        this.error = true;
        this.tryVibrate([100, 50, 100]); // Error vibration
      }
    } catch (error) {
      console.error(error);
      this.error = true;
      this.tryVibrate([100, 50, 100]); // Error vibration
    }

    form.resetForm();
    this.loading = false;
  }

  contact = {
    name: '',
    email: '',
    message: '',
  };
}