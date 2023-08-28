import { Injectable } from '@nestjs/common';

@Injectable()
export class PowerService {
  serverUrl: string = 'https://baspar.vazir.io/';
  status: boolean = true;

  getServerUrl(): string {
    return this.serverUrl;
  }

  setServerUrl(url: string): string {
    this.serverUrl = url;
    return this.serverUrl;
  }

  getStatus(): boolean {
    return this.status;
  }

  setStatus(status: boolean): boolean {
    this.status = status;
    return this.status;
  }
}
