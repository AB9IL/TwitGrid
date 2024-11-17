# TwitGrid: a TweetDeck alternative.

*Note: Twitter / X has turned into a complete shitshow AND TwitGrid will not function with all of the rate limiting.  This project will soom be changed to a Bash script called _BlueTabs_ and bring you browser tabs of feeds from Bluesky, Threads, and what remains of Twitter / X.*

TwitGrid is a simple, broadsheet layout for reading Twitter feeds that shows a
dense, instant overview of the latest posts from only the users you care about.
It doesn't mix multiple feeds up into an infinite-scrolling jumble.

#### With this fork you may save several batches of feeds to watch:
1. You must have Rofi or fzf for the menu.
2. Clone the TwitGrid directory and move it anywhere convenient to you.
3. Edit the runtwitgrid.sh script to correctly set paths to twitgrid.html and tw_alltopics (the file containing topics and Twitter feeds).
4. Edit the BROWSER variable to contain the command for opening your web browser.
5. Edit the file tw_alltopics to set your topic descriptions and associated batches of Twitter feeds.
6. On the command line, execute the script "runtwitgrit.sh"
7. To use Rofi instead of fzf, use the command "runtwitgrid.sh gui"
8. When the menu appears, select the topic or manually enter a user defined list of Twitter profiles.
9. Wait for the browser to appear.
10. The page will automatically refresh.
11. You do not need to edit the twitgrid.html file.

#### Here are nuket's original instructions, but you do not need to edit the handles:
It's easy to use:

1. Save a copy of [`twitgrid.html`](https://raw.githubusercontent.com/nuket/TwitGrid/master/twitgrid.html) anywhere.

2. Edit the lists of Twitter handles you want to see:

   ```
   const handlesTopInterests = 'vilimpoc checklyhq dspillere GreatDismal tim_nolet';
   const handlesFunStuff     = 'BVG_Kampagne fryuppolice KoreanTravel thingiverse NI_News steak_umm ConanOBrien taylorswift13 jimmykimmel';
   ```

3. Call the `render()` method, with optional alphabetical sorting:

   ```
   render(handlesTopInterests);
   render(handlesFunStuff, true);
   ```

4. Reload the page and enjoy.

5. **Desktops**

   *Page Up / Down* will smooth scroll the whole viewport, snapping to the next set of feeds.  
   *Mouse Wheel Up / Down* scrolls the individual user feeds.  
   *Home / End* scrolls to the top / bottom, as expected.

   **Mobile**

   Tap the navigation buttons to flip pages, or drag individual feeds.

## Live Demo

See a live demo version here -- https://vilimpoc.org/research/TwitGrid/

## The View

You will see feeds from only the specified handles, like so:

![](twitgrid.apng)

Because most people have usable long-term memory, you'll know what you have read
and haven't, somewhat in the vein of RSS (though less automatic).

There will not be an algorithm intermediating what you want to see and what you
actually see or surfacing things it thinks you might be interested in.

## Technology

It's a single page with inlined SVGs, no dependencies, pure ES6 Javascript. Not
even `lodash`. 

## Styling: Changing the Column Count

Edit this:

```
.twit  { flex: 0 0 20%; }
```

And this:

```
// Change this to suit the width of your monitor.
const columnCount = 5;
```
