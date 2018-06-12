Game List
---

Udacity iOS nanodegree project built with [IGDB API](https://igdb.github.io/api/).

This application let you list games based on a selected genre. Each game you visit will be saved on your "recents" list and persisted on your phone. There you will also be able to see which games you've marked as a favorite.

Install
---
To run the application you will need to install the dependencies with [Carthage](https://github.com/Carthage/Carthage#installing-carthage).

Run the commands
```
git clone https://github.com/pogramos/game-list.git
cd game-list
carthage bootstrap --platform iOS --no-use-binaries
```

Usage
---
When you enter the application you will face a tab bar with two items named "Recents" and "Genres". You can check the images [here](/Images/).

- ### Recents
    The games you visited recently, there you can filter the games by name in case your list grows too much. All of the games you marked as favorites will be sorted and displayed first on the list.

- ### Genres
    A list of genres, selecting one of them you'll be redirected to a list of games for that genre section.

- ### Games
    The games for this section will be displayed ordered by release date.

- ### Game (Detail)
    The selected game will be persisted in the CoreData model to be displayed on the recents Section. here you can also mark it as a favorite.

# Important Notes
### Tools and Libraries Used
- [Stencil](https://github.com/stencilproject/Stencil), [Sourcery](https://github.com/krzysztofzablocki/Sourcery).
  Boilerplate code generated from a template (CodingStructs.stencil - 'coded' by me)
- [Hero](https://github.com/lkzhao/Hero)
  For some cool transition animations
- [Chameleon](https://github.com/viccalexander/Chameleon)

The generated code is stored on [Generated](/Game%20List/Model/Generated/) folder and the template responsible for the code is on [Stencil Templates](/Game%20List/Stencil%20Templates/)
