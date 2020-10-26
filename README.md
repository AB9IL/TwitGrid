# TwitGrid: Because TweetDeck is a mess at times.

TwitGrid is a simple, broadsheet layout for reading Twitter feeds that shows a
dense, instant overview of the latest posts from only the users you care about.
It doesn't mix multiple feeds up into an infinite-scrolling jumble.

#### This fork is even easier than the original TwitGrid:
1. Clone the TwitGrid directory and move it anywhere convenient to you.
2. Edit the runtwitgrid.sh script to correctly contain the path to the html file and Twitter profile lists.
3. Edit the BROWSER variable to contain the command for opening your web browser.
4. On the command line, execute the script runtwitgrit.sh.
5. When the menu appears, select the topic or enter Twitter profiles manually.
6. Wait for the browser to appear.
7. The page will automatically refresh.

#### Here are the original reator's instructions:
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
