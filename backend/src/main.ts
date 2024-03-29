import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import * as morgan from 'morgan';
import * as cors from 'cors';
import * as dotenv from 'dotenv';
import * as clc from 'cli-color';

async function bootstrap() {
  dotenv.config();
  const port: string = process.env.PORT ?? String(3780);

  const app = await NestFactory.create(AppModule);

  app.use(cors());
  app.use(morgan('tiny'));

  await app.listen(port, () => {
    console.log('\n' + clc.bgCyan('Running on port: ' + port) + '\n');
  });
}

bootstrap();
