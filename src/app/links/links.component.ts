import { Component } from '@angular/core';

@Component({
  selector: 'app-links',
  templateUrl: './links.component.html',
  styleUrls: ['./links.component.scss'],
})

export class LinksComponent {
  scroll(id: string) {
    document.getElementById(id)?.scrollIntoView();
  }
}
