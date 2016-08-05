From: joe.hershberger@gmail.com (Joe Hershberger)
Date: Fri, 5 Aug 2016 15:38:52 -0500
Subject: [Cocci] Bad formatting when changing function prototypes
Message-ID: <CANr=Z=bpk1DKiXODccy8Ru0QkP8EX0_v6BfVA2PvsOZ9gpiVXw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I'm trying to use spatch to convert from one API to another across
many files and I'm running into a problem.

I don't know if I'm not configuring a setting properly or if it might be a bug.

Here's what I'm seeing... function prototypes or definitions that are
near or over the 80 char limit end up with poor formatting.

https://patchwork.ozlabs.org/patch/605756/

Eg:

-static int bfin_miiphy_read(const char *devname, uchar addr, uchar
reg, ushort *val)
+static int bfin_miiphy_read(struct mii_dev *bus, int addr, int devad, int reg
+       )

-static int bfin_miiphy_write(const char *devname, uchar addr, uchar
reg, ushort val)
+static int bfin_miiphy_write(struct mii_dev *bus, int addr, int devad,
+                            int reg, u16 val
+       )

-static int davinci_mii_phy_read(const char *devname, unsigned char
addr, unsigned char reg, unsigned short *value)
+static int davinci_mii_phy_read(struct mii_dev *bus, int addr, int devad,
+       int reg
+       )

The worst part is that it moves the close paren to the next line.

Also, I'm not sure how it decides how much indentation to use if it
truly needs an extra line for parameters. Ideally the indentation of
the next line of parameters would match the open paren position. It
seems to do that in some cases and not in other cases. I'm not sure
what affects it.

I had started back when 1.0.4 was the most recent, and I just now
tested with both 1.0.5 and master. All behave identically.

Does anyone have an idea what I can do to affect this behavior or does
it require a code change?

Thanks,
-Joe
