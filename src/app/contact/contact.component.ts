import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';

interface BuildInfo {
  timestamp: string;
  hash: string;
  buildTime: string;
  buildLocation: string;
  chunks: string[];
}

@Component({
  selector: 'app-contact',
  templateUrl: './contact.component.html',
  styleUrls: ['./contact.component.scss'],
})
export class ContactComponent implements OnInit {
  buildInfo?: BuildInfo;
  showDetails = false;

  constructor(private http: HttpClient) {}

  ngOnInit() {
    this.http.get<BuildInfo>('assets/build-info.json').subscribe(
      data => this.buildInfo = data,
      error => console.error('Error loading build info:', error)
    );
  }

  toggleDetails() {
    this.showDetails = !this.showDetails;
  }
}
