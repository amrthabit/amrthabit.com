import { Component } from '@angular/core';
import { OnInit } from '@angular/core';
import { Event, RouterEvent, Router, NavigationEnd } from '@angular/router';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
})
export class AppComponent {
  title = 'client';
  router: Router;

  constructor(router: Router) {
    this.router = router;
  }

  onload = function () {
    document.body.classList.remove('preload');
    console.log('loaded');
  };

  ngOnInit() {
    this.router.events.subscribe((val: Event) => {
      if (val instanceof NavigationEnd) {
        let fragmentIdx = val.urlAfterRedirects.lastIndexOf('#');
        if (
          fragmentIdx >= 0 &&
          fragmentIdx < val.urlAfterRedirects.length - 1
        ) {
          let fragment = val.urlAfterRedirects.substring(fragmentIdx + 1);
          console.log('fragment: ' + fragment);
          document.getElementById(fragment)?.scrollIntoView();
        }
      }
    });
  }
}
