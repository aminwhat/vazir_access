import { Module } from '@nestjs/common';
import { PowerGateway } from './power.gateway';
import { PowerService } from './power.service';

@Module({
  providers: [PowerGateway, PowerService],
})
export class PowerModule {}
