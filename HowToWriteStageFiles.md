A stage creator is currently far away (I'd say after I get holes and launchers right), but you can still create stages!

I recommend you use a terminal to run L-Echo, because that's where it outputs your camera angle when you press "A", which is quite necessary when making advanced stages.

If you have version 0.1.1+ ([revision 31](https://code.google.com/p/l-echo/source/detail?r=31)+), you can check if your stage works if you use "./l-echo -t [file](stage.md)".  It doesn't open the game.

Stages are XML files.  To begin, you can copy this template:

## Template: ##

```
<?xml version="1.0" standalone="no" ?>
<stage name="simple" start="grid_id" goals="0">
</stage>
```

If you have version 0.1.1+, you'll notice that this stage doesn't start, at that's because I made the loader much, much more strict.

### Attributes: ###

**name** is the name of the stage.

**start** is the id of the grid where the character will start.  Because there's no grid called "grid\_id" yet, L-Echo 0.1.1+ would exit with an error.

**goals** is the number of goals of the this stage.  You can have more goals than specified here.

Ok, now to add grids!

## Basic grids: ##

```
<grid id="grid_id" x="0" y="0" z="0" prev="NONE" next="NONE" [goal="1"] [nodraw="1"] [noland="1"] [trig="grid2"]/>
```

Before you eagerly copy and run that, remove everything in brackets (and the brackets too!).

### Attributes: ###

**id** is the name of the grid. IT IS CASE-SENSITIVE!

**x**, **y**, and **z** form the position of the grid.  Currently you can't change the way the grid face (well, you could use stairs...kind of).

**prev** is the previous grid, and **next** is the next.  ORDER DOES MATTER, so test your grid frequently!  Oh, and "NONE" means no link.

Optional:

If **goal** doesn't equal 0, the grid will have a goal (or echo) on top of it.

If **nodraw** doesn't equal 0, the grid will be invisible.

If **noland** doesn't equal 0, the character can't land on it from a launcher or hole.  Mainly used for vertical/diagonal obstacles (stairs).

**trig** is the grid that this grid changes into a goal when the character reaches its goal.  Currently only one trigger can be added from the files, but I plan to make the trigger system WAY more mature.

## t\_grids: ##

t\_grids are like basic grids but with an extra attribute called **next2**, basically the third neighbor of the t\_grid.

## angles and ranges ##

Before we dive into advanced grids, you need to know about angles and ranges:

```
<angle x="0" y="0" z="0">
</angle>
```

Angles just checks if your camera is at where it is. (Actually, it's implemented so that angles are ranges with same min and max).

To tell what your camera angle is during the game, press "A", and it will tell you via the terminal (in degrees).  Camera angle on the X axis is restricted to +/- 60 degrees.

Oh, and you might notice that the camera angle of L-Echo is in increments of 5 degrees.

0.1.1+ has a bug I had just realized writing this:  It doesn't need to get the z angle, because I don't count z rotation anyways...Oops.  You can omit z later on (0.1.2+), I guess.

```
<range x_min="0" x_max="10" y_min="0" y_max="10" z_min="0" z_max="10">
</range>
```

Again, you can omit z\_min and z\_max after 0.1.2+

Ranges makes you life easier by having, well, angle ranges instead of every damn angle.

## escgrids: ##

escgrids are grids who change position, neighbors and/or type when the camera angle change.

They go like this (DO NOT COPY INTO FILE!):

```
<escgrid [same attributes as basic grids]>
<angle [x=...]>
[any grid here]
</angle>
<range [x_min=...]>
[any grid here]
</range>
</escgrid>
```

Basically, all of the escgrid's children are angles or ranges, and when one of them match the current camera angle, the escgrid will sort of "become" the first grid inside the angle/range.

## freeform\_grid: ##

Not very well-named, these grids are any parallelograms; I use them only for obligatory walls for perspective absence and existence.

```
<freeform_grid [same attributes as basic grids]>
<angle [x=...]/> <!-- a half-width -->
<angle [x=...]/> <!-- a half-height -->
</escgrid>
```


## stairs: ##

More appropriate stairs:

```
<stair [same attributes as basic grids] direction="180"/>
```

The "direction" attribute is the direction in which the stairs will face (rotation around Y-axis, in other words).

## hole and launchers: ##

Holes and launchers are just like escgrids (for perspective absence and jumping).  Their implementations are a little broken, though...

## triggers: ##

In the original game, goals can be triggered upon completion of another.  In L-Echo, here's how you do it.  In the grid which will trigger other goals, insert a **triggers** construct.  The one and only **triggers** construct (in each grid, at least), holds many **trigger** constructs, which trigger a grid to become a goal if the (optional) conditions are true:

```
<trigger id="grid-to-make-into-a-goal">
<!-- optional conditions -->
<trigger>
```

Optional conditions include a goal element that tests if the specified grid is a goal:

```
<goal id="grid-to-check" />
```

**not** elements to invert stuff:

```
<not>
     <goal id="g1" />
</not>
```

and **and** and **or** elements to round out the list of boolean operators:

```
<and>
     <goal id="g1"/>
     <goal id="g2"/>
     <goal id="g3"/>
     <goal id="g4"/>
     <goal id="g5"/>
</and>
```

A good **triggers** construct may look like:

```
<triggers>
     <trigger id="g2">
          <not>
               <or>
                    <goal id="g1" />
                    <goal id="g3" />
               </or>
          </not>
     </trigger>
</triggers>
```

## Future Format? ##

It is likely that in the future redux of L-Echo (if any), that Lua or any managed code will be used for a more dynamic stage.  I'll probably still support XML, though.

## Happy hacking! ##