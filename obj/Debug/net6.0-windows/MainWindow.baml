   M S B A M L   `   `   `  ����R  NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35L5clr-namespace:System.Diagnostics;assembly=WindowsBaseSystem.Diagnostics  5   	   R8clr-namespace:System.ComponentModel;assembly=WindowsBaseSystem.ComponentModel  5	   	    	SnakeGame   SnakeGame.SnakeGameWindow   5   	   W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation      5   	   R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml      5   	   @d2http://schemas.microsoft.com/expression/blend/2008      5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006      5   	   Fdiag5clr-namespace:System.Diagnostics;assembly=WindowsBase      5   	   Hscm8clr-namespace:System.ComponentModel;assembly=WindowsBase      5	   	   -   5          �Name$  window��5   	    � Title$ Snake - Score 0��5
   	    � SizeToContent$ WidthAndHeight=�5   	    � Cursor$ Cross��5   	    � 
ResizeMode$ NoResize=�5   	    � WindowStyle$
 None=�5   	    � 	Resources 5         HighScoreListViewSource �� Source �� ElementName	 �� Path
 �� SortDescriptions+   %System.ComponentModel.SortDescription   	Direction   PropertyName��%�   &	        �� 5   
    5      �� $ window��$	 HighscoreList�
 5        5      $ 
Descending=�6&   $ Score��6=   5      5      .��5      ]� 
���   �.+�5   
   � -   5        $��pnlTitleBar��5   $   $	��Top=�6    � ColumnDefinitions 5!      �� 5"      $��* �6#   �� 5#      $��* �6#   �� 5$      $
��Auto �6#    5'       �� 
TargetType �� Property �� Value��%�   '��       �� 5(      " ��6   .�5)      ��  � ��$ Consolas)�63   �� 5*       � ��
 �����63   �� 5+       � ��$ 24(�61   �� 5,       � ��$
 Bold"�63   5-      5.      .+�50      � $��10,0,0,0q�6   .+�51      �� Score:6%   �� 52      -   5        $��tbStatusScore��52      064   53      � 55      $��1��6   .+�56      �� Speed:6%   �� 57      -   5        $��tbStatusSpeed��57      064   58      �� 5:      -   5        $��btnClose��5;   I   $��2��5:      $��Right=�6%   
������ 
�������$
��Bold"�5;      $��20(�6'   $��0q�65   $
��10,0q�5<      .��6$   X5>      5@      �� 5B   
   
���   �$��3q�6%    5D        txtBlock_Title  txtBlock_Body  txtBlock_Instruction  border_PopUpMessage��%C  &	       &	 B    &	 X    &	 �    �� 5E      " ��6/   .�5F      ��  � ��$ Center=�6<   �� 5G       � ��$ 0,20,0,0q�6/   �� 5H       � ��
 �����63   �� 5I       � ��$ 32(�61   �� 5J       � ��$
 Bold"�63   �� 5K       � ��$
 Wrap=�65   �� 5L       �@��TextAlignment$ Center=�66   5M      �� 5N      " ��6.   .�5O      ��  � ��$ Center=�6<   �� 5P       � ��$ 20q�6/   �� 5Q       � ��
 �����63   �� 5R       � ��$ 18(�61   �� 5S       � ��$
 Wrap=�65   �� 5T       �@��TextAlignment$ Center=�66   5U      �� 5V      " ��65   .�5W      ��  � ��$ Center=�6<   �� 5X       � ��$
 20,0q�6/   �� 5Y       � ��
 ��h{�63   �� 5Z       � ��$ 18(�61   �� 5[       � ��$
 Bold"�63   �� 5\       � ��$
 Wrap=�65   �� 5]       �@��TextAlignment$ Center=�66   5^      �� 5_      " ��64   .�5`      ��  � ��$ Center=�6<   �� 5a       � ��
 �����64   �� 5b       � ��$ 2q�68   �� 5c       � ��$	 300��6.   �� 5d       � ��$	 300��6/   �� 5e       �@��Left$ 50��64   �� 5f       �@��Top$ 50��63   �� 5g       �@K�ZIndex$ 1��65   �� 5h       � y�$ 	Collapsed=�63   5i      5j      ._�5l      �� -   5        $��GameArea��5l      $
}�True��6%   $	��400��69   $	��400��6E   
��� d �.+�5n      �� -   5        $��bdrWelcomeMessage��5n      #��[ 62   ._�5o      ��  �� Orientation$ Vertical=�6!   
���   �.+�5q      �� #��[ 6$   Snake5s      �� 5u      #��[ 6$   ljUse the arrow keys to control the snake. Make it eat the red apples, but be sure not to eat your own tail!5w      �� 5y      #��[ 6$   Press SPACE to start!5{      5}      5~      �� 5�      -   5        $��bdrNewHighScore��5�      #��[ 60   ._�5�      �� $ Vertical=�6!   
���   �.+�5�      �� #��[ 6$   New Highscore!5�      �� 5�      #��[ 6$   B@Congratulations - you got a high score! Enter your name below...5�      �� 5�      -	   5        $��txtPlayerName��5�   "   $��24(�5�   "   $
��Bold"�5�   "    �� 	MaxLength$ 8��5�   "   $
��20,0q�5�   "   $
��0, 3q�5�   "    �� TextAlignment$ Center=�5�   "   $��Center=�5�   "   $��0q�5�   "   
�������.��5�   5   5�      �� 5�      -
   5        $��btnAddToHighscoreList��5�   !   $��16(�6>   $��Center=�6L   $	��5,3q�5�   E   $��0, 20q�6S   .��6b   Add to highscore list5�      5�      5�      �� 5�      -   5        $��bdrHighscoreList��5�      #��[ 61   ._�5�      �� $ Vertical=�6!   
���   �.+�5�      �� #��[ 6$   High Score List5�      �� 5�      $��20,10,20,10q�6'   
�������$	��0,1q�6P   ��6f   ��  �� Source# [  ��5�      �� 5�   "   .R�5�   &   ]� $��	10,2,10,2q�60   .+�5�   *   �� $
��Left=�6P   $��18(�6f   
���������64   �� *
PlayerName+6�   �� 5�   *   $��Right=�6K   $��18(�6b   
�������$��Right=�6�   ��64   �� *Score+6�   5�   '   5�   #   5�      �� 5�      #��[ 6$   
�������" Press SPACE to start a new game!5�      5�      5�      �� 5�      -   5        $��bdrGameOver��5�      #��[ 6,   ._�5�      �� $ Vertical=�6!   
���   �.+�5�      �� #��[ 6$   	GAME OVER5�      �� 5�      #��[ 6$   $��
20,20,20,5q�6K   Your score:5�      �� 5�      -   5        $��tbFinalScore��5�   $   #��[ 68   $��40(�6f   05�      �� 5�      -   5        $��btnViewHighscoreList��5�   !   $��16(�6=   $��Center=�6K   $	��5,3q�5�   D   $��
0, 15,0,20q�6R   .��6f   View highscore list5�      �� 5�      #��[ 6$   
�������&$Or, press SPACE to start a new game!5�      5�      5�      5�      5�      5�      5�      