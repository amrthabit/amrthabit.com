import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { catchError, of } from 'rxjs';

interface BuildInfoChunkMobile {
  file: string;
  name: string;
  rawSize: string;
  transferSize: string;
}

interface BuildInfo {
  timestamp: string;
  hash: string;
  buildTime: string;
  buildLocation: string;
  chunks: string[];
  chunksMobile: BuildInfoChunkMobile[];
}

@Component({
  selector: 'app-contact',
  templateUrl: './contact.component.html',
  styleUrls: ['./contact.component.scss'],
})
export class ContactComponent implements OnInit {
  buildInfo?: BuildInfo;
  showDetails = false;
  isMobile = window.innerWidth <= 768;

  constructor(private http: HttpClient) {
    // Listen for window resize events
    window.addEventListener('resize', () => {
      this.isMobile = window.innerWidth <= 768;
    });
  }

  ngOnInit() {
    // Try both paths for build-info.json
    this.loadBuildInfo();
  }

  private loadBuildInfo() {
    const paths = ['/assets/build-info.json', 'assets/build-info.json'];
    
    // Try each path until one works
    for (const path of paths) {
      this.http.get<BuildInfo>(path).pipe(
        catchError(error => {
          console.warn(`Failed to load build info from ${path}:`, error);
          return of(undefined);
        })
      ).subscribe(data => {
        if (data) {
          this.buildInfo = data;
          console.log('Successfully loaded build info from:', path);
        }
      });
    }
  }

  toggleDetails() {
    this.showDetails = !this.showDetails;
  }
}