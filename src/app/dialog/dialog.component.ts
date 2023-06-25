import {
  ChangeDetectionStrategy,
  ChangeDetectorRef,
  Component,
  ElementRef,
  EventEmitter,
  Input,
  OnInit,
  Output,
  ViewChild,
  inject,
} from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-dialog',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './dialog.component.html',
  styleUrls: ['./dialog.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class DialogComponent implements OnInit {
  @Input() dialogTitle!: string;
  @Input() open!: boolean;
  @ViewChild('appDialog', { static: true })
  dialog!: ElementRef<HTMLDialogElement>;
  cdr = inject(ChangeDetectorRef);

  ngOnInit(): void {
    // this.dialog.nativeElement.showModal();
    // this.cdr.detectChanges();
  }

  ngOnDestroy(): void {
    this.dialog.nativeElement.close();
    this.cdr.detectChanges();
  }

  closeDialog() {
    this.dialog.nativeElement.close();
    this.cdr.detectChanges();
  }

  ngOnChanges(): void {
    if (this.open) {
      this.dialog.nativeElement.showModal();
      this.cdr.detectChanges();
    } else {
      this.dialog.nativeElement.close();
      this.cdr.detectChanges();
    }
  }
}
