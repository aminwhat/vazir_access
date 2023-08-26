import { Module } from '@nestjs/common';
import { HealthModule } from './health/health.module';
import { ServeStaticModule } from '@nestjs/serve-static';
import { join } from 'path';
import { PowerModule } from './power/power.module';

@Module({
  imports: [
    HealthModule,
    ServeStaticModule.forRoot({
      rootPath: join(__dirname, '..', 'static'),
    }),
    PowerModule,
  ],
})
export class AppModule {}
