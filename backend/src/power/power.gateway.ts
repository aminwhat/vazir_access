import {
  ConnectedSocket,
  MessageBody,
  SubscribeMessage,
  WebSocketGateway,
  WebSocketServer,
} from '@nestjs/websockets';

import { Socket, Server } from 'socket.io';
import { PowerService } from './power.service';

@WebSocketGateway({ namespace: 'power' })
export class PowerGateway {
  constructor(private powerService: PowerService) {}

  @WebSocketServer()
  server: Server;

  @SubscribeMessage('geturl')
  GetUrl(@ConnectedSocket() client: Socket) {
    this.server.emit('url', this.powerService.getServerUrl());
  }

  @SubscribeMessage('seturl')
  SetUrl(@ConnectedSocket() client: Socket, @MessageBody() url: string) {
    console.log(url);
    this.server.emit('url', this.powerService.setServerUrl(url));
  }

  @SubscribeMessage('getstatus')
  GetStatus(@ConnectedSocket() client: Socket) {
    this.server.emit('status', this.powerService.getStatus());
  }

  @SubscribeMessage('setstatus')
  SetStatus(@ConnectedSocket() client: Socket, @MessageBody() status: boolean) {
    console.log(status);
    this.server.emit('status', this.powerService.setStatus(status));
  }
}
