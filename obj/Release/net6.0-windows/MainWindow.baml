   M S B A M L   `   `   `  ���� R  NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35L5clr-namespace:System.Diagnostics;assembly=WindowsBaseSystem.Diagnostics  R8clr-namespace:System.ComponentModel;assembly=WindowsBaseSystem.ComponentModel   	SnakeGame   SnakeGame.SnakeGameWindow   W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation      R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml      @d2http://schemas.microsoft.com/expression/blend/2008      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006      Fdiag5clr-namespace:System.Diagnostics;assembly=WindowsBase      Hscm8clr-namespace:System.ComponentModel;assembly=WindowsBase      -     �Name$  window�� � Title$ Snake - Score 0�� � SizeToContent$ WidthAndHeight=� � Cursor$ Cross�� � 
ResizeMode$ NoResize=� � WindowStyle$
 None=� � 	Resources    HighScoreListViewSource �� Source �� ElementName	 �� Path
 �� SortDescriptions+   %System.ComponentModel.SortDescription   	Direction   PropertyName��%_   &	        ��  �� $ window��$	 HighscoreList�
   $ 
Descending=�$ Score��.��]� 
���   �.+�� -   $��pnlTitleBar��$	��Top=� � ColumnDefinitions �� $��* ��� $��* ��� $
��Auto �  �� 
TargetType �� Property �� Value��%y   '��       �� " ��.���  � ��$ Consolas)���  � ��
 �������  � ��$ 24(���  � ��$
 Bold"�.+�� $��10,0,0,0q�.+��� Score:�� -   $��tbStatusScore��0� $��1��.+��� Speed:�� -   $��tbStatusSpeed��0�� -   $��btnClose��$��2��$��Right=�
������ 
�������$
��Bold"�$��20(�$��0q�$
��10,0q�.��X�� 
���   �$��3q�   txtBlock_Title  txtBlock_Body  txtBlock_Instruction  border_PopUpMessage��%Q  &	       &	 �     &	 t    &	 9    �� " ��.���  � ��$ Center=���  � ��$ 0,20,0,0q���  � ��
 �������  � ��$ 32(���  � ��$
 Bold"���  � ��$
 Wrap=���  �@��TextAlignment$ Center=��� " ��.���  � ��$ Center=���  � ��$ 20q���  � ��
 �������  � ��$ 18(���  � ��$
 Wrap=���  �@��TextAlignment$ Center=��� " ��.���  � ��$ Center=���  � ��$
 20,0q���  � ��
 ��h{���  � ��$ 18(���  � ��$
 Bold"���  � ��$
 Wrap=���  �@��TextAlignment$ Center=��� " ��.���  � ��$ Center=���  � ��
 �������  � ��$ 2q���  � ��$	 300����  � ��$	 300����  �@��Left$ 50����  �@��Top$ 50����  �@K�ZIndex$ 1����  � y�$ 	Collapsed=�._��� -   $��GameArea��$
}�True��$	��400��$	��400��
��� d �.+��� -   $��bdrWelcomeMessage��#��[ ._���  �� Orientation$ Vertical=�
���   �.+��� #��[ Snake�� #��[ ljUse the arrow keys to control the snake. Make it eat the red apples, but be sure not to eat your own tail!�� #��[ Press SPACE to start!�� -   $��bdrNewHighScore��#��[ ._��� $ Vertical=�
���   �.+��� #��[ New Highscore!�� #��[ B@Congratulations - you got a high score! Enter your name below...�� -	   $��txtPlayerName��$��24(�$
��Bold"� �� 	MaxLength$ 8��$
��20,0q�$
��0, 3q� �� TextAlignment$ Center=�$��Center=�$��0q�
�������.���� -
   $��btnAddToHighscoreList��$��16(�$��Center=�$	��5,3q�$��0, 20q�.��Add to highscore list�� -   $��bdrHighscoreList��#��[ ._��� $ Vertical=�
���   �.+��� #��[ High Score List�� $��20,10,20,10q�
�������$	��0,1q�����  �� Source# [  ���� .R�]� $��	10,2,10,2q�.+��� $
��Left=�$��18(�
����������� *
PlayerName+�� $��Right=�$��18(�
�������$��Right=����� *Score+�� #��[ 
�������" Press SPACE to start a new game!�� -   $��bdrGameOver��#��[ ._��� $ Vertical=�
���   �.+��� #��[ 	GAME OVER�� #��[ $��
20,20,20,5q�Your score:�� -   $��tbFinalScore��#��[ $��40(�0�� -   $��btnViewHighscoreList��$��16(�$��Center=�$	��5,3q�$��
0, 15,0,20q�.��View highscore list�� #��[ 
�������&$Or, press SPACE to start a new game!