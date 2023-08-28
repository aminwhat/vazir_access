import { Module } from '@nestjs/common';
import { ServeStaticModule } from '@nestjs/serve-static';
import { join } from 'path';
import { PowerModule } from './power/power.module';
import { IndexModule } from './index/index.module';

@Module({
  imports: [
    ServeStaticModule.forRoot({
      rootPath: join(__dirname, '..', 'static'),
    }),
    PowerModule,
    IndexModule,
  ],
})
export class AppModule {}
