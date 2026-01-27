import { Component, signal } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { MatCardModule} from '@angular/material/card';
//, MatCard, MatCardHeader, MatCardTitle, MatCardSubtitle, MatCardActions 
@Component({
  selector: 'app-root',
  imports: [RouterOutlet, MatCardModule],
  templateUrl: './app.html',
  styleUrl: './app.css'
})
export class App {
  protected readonly title = signal('exlink');
}
