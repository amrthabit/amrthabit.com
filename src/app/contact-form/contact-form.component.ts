import { animate, style, transition, trigger } from '@angular/animations';
import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormsModule, NgForm } from '@angular/forms';
import { DialogComponent } from '../dialog/dialog.component';

interface ContactForm {
  name: string;
  email: string;
  message: string;
}

@Component({
  selector: 'app-contact-form',
  templateUrl: './contact-form.component.html',
  animations: [
    // Slide animation for alerts (success/error messages)
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
    // Slide animation for loading indicator
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
  // Form data
  contact: ContactForm = {
    name: '',
    email: '',
    message: '',
  };

  // UI state
  loading = false;
  success = false;
  error = false;

  // API endpoint
  private readonly API_ENDPOINT = 'https://uynr3m7gfcirffdr45lwiqpfsq0ptjos.lambda-url.us-east-1.on.aws/';

  // Vibration patterns
  private readonly VIBRATION_PATTERNS = {
    error: [5, 100, 5],      // Short error pattern
    success: [50, 50, 100],  // Success pattern
    apiError: [100, 50, 100] // API error pattern
  };

  /**
   * Attempts to vibrate the device with a given pattern
   * Only works after user interaction (sticky activation)
   */
  private vibrate(pattern: number[]): void {
    if ('vibrate' in navigator) {
      navigator.vibrate(pattern);
    }
  }

  /**
   * Handles form validation and focuses on invalid fields
   */
  private validateForm(form: NgForm): boolean {
    if (this.loading) return false;

    const controls = form.controls;
    const invalidFields = [
      { id: 'message', control: controls['message'] },
      { id: 'email', control: controls['email'] },
      { id: 'name', control: controls['name'] }
    ];

    // Focus on first invalid field
    for (const field of invalidFields) {
      if (!field.control.valid) {
        document.getElementById(field.id)?.focus();
        
        // Special handling for name field
        if (field.id === 'name') {
          field.control.markAsDirty();
          field.control.markAsTouched();
        }
      }
    }

    if (!form.valid) {
      this.vibrate(this.VIBRATION_PATTERNS.error);
      this.showSubmitError();
      return false;
    }

    return true;
  }

  /**
   * Shows and then hides the submit button error state
   */
  private showSubmitError(): void {
    const submitButton = document.getElementById('submit');
    if (submitButton) {
      submitButton.classList.add('error');
      setTimeout(() => submitButton.classList.remove('error'), 500);
    }
  }

  /**
   * Sends the form data to the API
   */
  private async submitToApi(): Promise<boolean> {
    try {
      const response = await fetch(this.API_ENDPOINT, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(this.contact)
      });

      return response.status === 200;
    } catch (error) {
      console.error('API Error:', error);
      return false;
    }
  }

  /**
   * Resets the form state
   */
  closeDialog(): void {
    this.success = false;
    this.error = false;
  }

  /**
   * Main form submission handler
   */
  async onSubmit(form: NgForm): Promise<void> {
    // Validate form
    if (!this.validateForm(form)) return;

    // Submit form
    this.loading = true;
    const success = await this.submitToApi();
    
    // Handle response
    if (success) {
      this.success = true;
      this.vibrate(this.VIBRATION_PATTERNS.success);
    } else {
      this.error = true;
      this.vibrate(this.VIBRATION_PATTERNS.apiError);
    }

    // Clean up
    form.resetForm();
    this.loading = false;
  }
}