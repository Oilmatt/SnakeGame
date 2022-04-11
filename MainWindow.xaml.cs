using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Shapes;
using System.Windows.Threading;
using System.IO;
using System.Linq;
using System.Xml.Serialization;

namespace SnakeGame
{
    public partial class SnakeGameWindow : Window
    {
        private DispatcherTimer gameTickTimer = new DispatcherTimer();

        const int SnakeSquareSize = 20;             // Size of a snake part
        const int SnakeStartLength = 3;             // Staring length of the snake
        const int SnakeLengthIncrease = 3;          // Increase in snake length when food is eaten
        const int EatFoodScoreIncriment = 1;        // Score incriment when food is eaten
        const int SnakeStartSpeed = 400;            // Tick interval in milliseconds 
        const int SnakeSpeedThreshold = 100;        // Minimum tick interval in milliseconds
        const int MaxHighScoreListEntryCount = 5;   // Maximum number of high score entries allowed

        public ObservableCollection<SnakeHighScore> HighscoreList { get; set; } =
            new ObservableCollection<SnakeHighScore>();

        private UIElement snakeFood = new UIElement();
        private SolidColorBrush foodBrush = Brushes.Red;
        private SolidColorBrush snakeBodyBrush = Brushes.DarkBlue;
        private SolidColorBrush snakeHeadBrush = Brushes.LightBlue;

        private Random rdm = new Random();
        private List<SnakePart> snakeParts = new List<SnakePart>();

        private enum SnakeDirection
        {
            Up,
            Down,
            Left,
            Right
        }

        private SnakeDirection snakeDirection = SnakeDirection.Right;

        private int snakeLength;
        private int currentScore;
        private bool gameEnded;
        private bool disableSpaceBar = false;

        public SnakeGameWindow()
        {
            InitializeComponent();
            gameTickTimer.Tick += GameTickTimer_Tick;
            LoadHighScoreList();
        }

        private void Window_ContentRendered(object sender, EventArgs e)
        {
            bdrWelcomeMessage.Visibility = Visibility.Visible;
        }

        private void Window_KeyUp(object sender, KeyEventArgs e)
        {
            if (!gameEnded)
            {
                SnakeDirection originalSnakeDirection = snakeDirection;

                switch (e.Key)
                {
                    case Key.Up:
                        if (snakeDirection != SnakeDirection.Down)
                        {
                            snakeDirection = SnakeDirection.Up;
                        }

                        break;

                    case Key.Down:
                        if (snakeDirection != SnakeDirection.Up)
                        {
                            snakeDirection = SnakeDirection.Down;
                        }

                        break;

                    case Key.Left:
                        if (snakeDirection != SnakeDirection.Right)
                        {
                            snakeDirection = SnakeDirection.Left;
                        }

                        break;

                    case Key.Right:
                        if (snakeDirection != SnakeDirection.Left)
                        {
                            snakeDirection = SnakeDirection.Right;
                        }

                        break;

                    case Key.Space:
                        StartNewGame();
                        break;
                }

                if (snakeDirection != originalSnakeDirection)
                {
                    gameTickTimer.Stop();
                    MoveSnake();

                    if (!gameEnded)
                    {
                        gameTickTimer.Start();
                    }
                }
            }

            if (e.Key == Key.Space && !disableSpaceBar)
            {
                StartNewGame();
            }
        }

        private void Window_MouseDown(object sender, MouseButtonEventArgs e)
        {
            this.DragMove();
        }

        private void BtnClose_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void BtnAddToHighscoreList_Click(object sender, RoutedEventArgs e)
        {
            disableSpaceBar = false;
            
            int newIndex = 0;

            if ((this.HighscoreList.Count > 0) && (currentScore < this.HighscoreList.Max(x => x.Score)))
            {
                SnakeHighScore justAbove = this.HighscoreList.OrderByDescending(x => x.Score)
                    .First(x => x.Score >= currentScore);
                if (justAbove != null)
                {
                    newIndex = this.HighscoreList.IndexOf(justAbove) + 1;
                }
            }

            this.HighscoreList.Insert(newIndex, new SnakeHighScore()
            {
                PlayerName = txtPlayerName.Text,
                Score = currentScore
            });
            
            while (this.HighscoreList.Count > MaxHighScoreListEntryCount)
            {
                this.HighscoreList.RemoveAt(MaxHighScoreListEntryCount);
            }
            
            SaveHighScoreList();


            bdrNewHighScore.Visibility = Visibility.Collapsed;
            bdrHighscoreList.Visibility = Visibility.Visible;
        }

        private void BtnViewHighscoreList_Click(object sender, RoutedEventArgs e)
        {
            bdrGameOver.Visibility = Visibility.Collapsed;
            bdrHighscoreList.Visibility = Visibility.Visible;
        }

        private void GameTickTimer_Tick(object sender, EventArgs e)
        {
            MoveSnake();
        }

        private void StartNewGame()
        {
            ClearSnake();
            ClearFood();

            bdrWelcomeMessage.Visibility = Visibility.Collapsed;
            bdrHighscoreList.Visibility = Visibility.Collapsed;
            bdrGameOver.Visibility = Visibility.Collapsed;

            snakeLength = SnakeStartLength; //Resets snake length
            snakeDirection = SnakeDirection.Right; //Resets default direction
            currentScore = 0;
            gameTickTimer.Interval = TimeSpan.FromMilliseconds(SnakeStartSpeed); //Resets ticker interval
            snakeParts.Add(new SnakePart()
            {
                Position = new Point(SnakeSquareSize * 5, SnakeSquareSize * 5)
            }); //Adds a new snakepart to snakeParts list and sets position to coordinate 5, 5

            UpdateGameStatus();
            DrawSnake();
            DrawFood();

            gameEnded = false;

            gameTickTimer.IsEnabled = true;
        }

        private void EndGame()
        {
            gameTickTimer.IsEnabled = false;
            gameEnded = true;

            bool isNewHighScore = false;

            if (currentScore > 0)
            {
                int lowestHighScore = (this.HighscoreList.Count > 0 ? this.HighscoreList.Min(x => x.Score) : 0);

                if ((currentScore > lowestHighScore) || (this.HighscoreList.Count < MaxHighScoreListEntryCount))
                {
                    disableSpaceBar = true;
                    bdrNewHighScore.Visibility = Visibility.Visible;
                    txtPlayerName.Focus();
                    isNewHighScore = true;
                }
            }

            if (!isNewHighScore)
            {
                tbFinalScore.Text = currentScore.ToString();
                bdrGameOver.Visibility = Visibility.Visible;
            }
        }

        private void LoadHighScoreList()
        {
            if (File.Exists("snake_highscorelist.xml"))
            {
                XmlSerializer serializer = new XmlSerializer(typeof(List<SnakeHighScore>));
                using (Stream reader = new FileStream("snake_highscorelist.xml", FileMode.Open))
                {
                    List<SnakeHighScore> tempList = (List<SnakeHighScore>) serializer.Deserialize(reader);
                    this.HighscoreList.Clear();
                    foreach (SnakeHighScore item in tempList)
                    {
                        this.HighscoreList.Add(item);
                    }
                }
            }
        }

        private void SaveHighScoreList()
        {
            XmlSerializer serializer = new XmlSerializer(typeof(ObservableCollection<SnakeHighScore>));
            using (Stream writer = new FileStream("snake_highscorelist.xml", FileMode.Create))
            {
                serializer.Serialize(writer, this.HighscoreList);
            }
        }

        private void MoveSnake()
        {
            while (snakeParts.Count >= snakeLength)
            {
                GameArea.Children.Remove(snakeParts[0].UiElement);
                snakeParts.RemoveAt(0);
            }

            foreach (SnakePart snakePart in snakeParts)
            {
                (snakePart.UiElement as Rectangle).Fill = snakeBodyBrush;
                snakePart.IsHead = false;
            }

            SnakePart currentSnakeHead = snakeParts[snakeParts.Count - 1];
            double nextX = currentSnakeHead.Position.X;
            double nextY = currentSnakeHead.Position.Y;

            switch (snakeDirection)
            {
                case SnakeDirection.Up:
                    nextY -= SnakeSquareSize;
                    break;
                case SnakeDirection.Down:
                    nextY += SnakeSquareSize;
                    break;
                case SnakeDirection.Left:
                    nextX -= SnakeSquareSize;
                    break;
                case SnakeDirection.Right:
                    nextX += SnakeSquareSize;
                    break;
            }

            //Passing through walls teleports to opposite wall
            if (nextX < 0)
            {
                nextX = GameArea.ActualWidth - SnakeSquareSize;
            }

            if (nextY < 0)
            {
                nextY = GameArea.ActualWidth - SnakeSquareSize;
            }

            if (nextX > GameArea.ActualWidth - SnakeSquareSize)
            {
                nextX = 0;
            }

            if (nextY > GameArea.ActualWidth - SnakeSquareSize)
            {
                nextY = 0;
            }

            snakeParts.Add(new SnakePart()
            {
                Position = new Point(nextX, nextY),
                IsHead = true
            });
            DrawSnake();
            DoCollisionCheck();
        }

        private void DrawSnake()
        {
            foreach (SnakePart snakePart in snakeParts)
            {
                if (snakePart.UiElement == null)
                {
                    snakePart.UiElement = new Rectangle()
                    {
                        Width = SnakeSquareSize,
                        Height = SnakeSquareSize,
                        Fill = (snakePart.IsHead ? snakeHeadBrush : snakeBodyBrush)
                    };
                    GameArea.Children.Add(snakePart.UiElement);
                    Canvas.SetTop(snakePart.UiElement, snakePart.Position.Y);
                    Canvas.SetLeft(snakePart.UiElement, snakePart.Position.X);
                }
            }
        }

        private void DrawFood()
        {
            Point foodPosition = GetNextFoodPosition();
            snakeFood = new Ellipse()
            {
                Width = SnakeSquareSize,
                Height = SnakeSquareSize,
                Fill = foodBrush
            };
            GameArea.Children.Add(snakeFood);
            Canvas.SetTop(snakeFood, foodPosition.Y);
            Canvas.SetLeft(snakeFood, foodPosition.X);
        }

        private void EatFood()
        {
            snakeLength += SnakeLengthIncrease;
            currentScore += EatFoodScoreIncriment;
            int timerInterval = Math.Max(SnakeSpeedThreshold, (int) gameTickTimer.Interval.Milliseconds - currentScore);
            gameTickTimer.Interval = TimeSpan.FromMilliseconds(timerInterval);
            ClearFood();
            DrawFood();
            UpdateGameStatus();
        }

        private void ClearSnake()
        {
            for (int i = snakeParts.Count - 1; i >=0; i--)
            {
                GameArea.Children.Remove(snakeParts[i].UiElement);
                snakeParts.RemoveAt(i);
            }
        }

        private void ClearFood()
        {
            GameArea.Children.Remove(snakeFood);
        }

        private void DoCollisionCheck()
        {
            SnakePart snakeHead = snakeParts[snakeParts.Count - 1];

            if (SnakeSelfCollision(snakeHead))
            {
                EndGame();
            }

            if (SnakeFoodCollision(snakeHead))
            {
                EatFood();
            }
        }

        private void UpdateGameStatus()
        {
            this.tbStatusScore.Text = currentScore.ToString();
            this.tbStatusSpeed.Text = gameTickTimer.Interval.TotalMilliseconds.ToString();
        }

        private bool SnakeSelfCollision(SnakePart snakeHead)
        {
            for (int i = 0; i < snakeParts.Count - 2; i++)
            {
                if (snakeParts[i].Position.X == snakeHead.Position.X &&
                    snakeParts[i].Position.Y == snakeHead.Position.Y)
                {
                    return true;
                }
            }

            return false;
        }

        private bool SnakeFoodCollision(SnakePart snakeHead)
        {
            if (snakeHead.Position.X == Canvas.GetLeft(snakeFood) &&
                snakeHead.Position.Y == Canvas.GetTop(snakeFood))
            {
                return true;
            }

            return false;
        }

        private Point GetNextFoodPosition()
        {
            var maxX = (int) (GameArea.ActualWidth / SnakeSquareSize);
            var maxY = (int) (GameArea.ActualHeight / SnakeSquareSize);
            int foodX = rdm.Next(0, maxX) * SnakeSquareSize;
            int foodY = rdm.Next(0, maxY) * SnakeSquareSize;

            foreach (SnakePart snakePart in snakeParts)
            {
                if (snakePart.Position.X == foodX && snakePart.Position.Y == foodY)
                {
                    return GetNextFoodPosition();
                }
            }

            return new Point(foodX, foodY);
        }
    }
}