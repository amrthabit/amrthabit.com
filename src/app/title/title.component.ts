import { Component } from '@angular/core';

@Component({
  selector: 'app-title',
  templateUrl: './title.component.html',
  styleUrls: ['./title.component.scss'],
})
export class TitleComponent {
  scroll(id: string) {
    document.getElementById(id)?.scrollIntoView();
  }

  // Commented out animation cycles for reference
  //  add .glowing class to .name after 2 seconds
  // ngAfterViewInit() {
  //   setTimeout(() => {
  //     document.querySelector('.name')?.classList.add('glowing');
  //   }, 500);
  //   setTimeout(() => {
  //     document.querySelector('.name')?.classList.remove('glowing');
  //   }, 2000);
  // }
  // make it cyle between glowing and not glowing
  // ngAfterViewInit() {
  //   setInterval(() => {
  //     document.querySelector('.name')?.classList.toggle('glowing');
  //   }, 1000);
  // }
}
