import { CommonModule } from '@angular/common';
import {
  ChangeDetectionStrategy,
  ChangeDetectorRef,
  Component,
  ElementRef,
  Input,
  OnInit,
  OnDestroy,
  OnChanges,
  ViewChild,
  inject,
} from '@angular/core';

@Component({
  selector: 'app-dialog',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './dialog.component.html',
  styleUrls: ['./dialog.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class DialogComponent implements OnInit, OnDestroy, OnChanges {
  @Input() dialogTitle!: string;
  @Input() open!: boolean;
  @ViewChild('appDialog', { static: true })
  dialog!: ElementRef<HTMLDialogElement>;

  cdr = inject(ChangeDetectorRef);

  lockScroll(e: Event): void {
    console.log('scroll');
    e.preventDefault();
  }

  ngOnInit(): void {
    // Initialize dialog state
    if (this.open) {
      this.dialog.nativeElement.showModal();
    }
  }

  ngOnDestroy(): void {
    this.dialog.nativeElement.close();
    this.cdr.detectChanges();
  }

  closeDialog(): void {
    this.dialog.nativeElement.close();
    document.body.classList.remove('no-scroll');
    this.cdr.detectChanges();
  }

  ngOnChanges(): void {
    if (this.open) {
      this.dialog.nativeElement.showModal();
      document.body.classList.add('no-scroll');
      this.cdr.detectChanges();
    } else {
      this.dialog.nativeElement.close();
      document.body.classList.remove('no-scroll');
      this.cdr.detectChanges();
    }
  }
}