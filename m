From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 17 Nov 2016 23:48:42 +0100 (CET)
Subject: [Cocci] Fwd: Fwd: Re: min/max mtu field in struct net_device
In-Reply-To: <2c575398-b566-6529-4f30-10e8e0c8fcba@broadcom.com>
References: <3a964780-2513-624f-6a2a-ae507398b0a8@broadcom.com>
 <2c575398-b566-6529-4f30-10e8e0c8fcba@broadcom.com>
Message-ID: <alpine.DEB.2.20.1611172300070.2001@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 17 Nov 2016, Arend Van Spriel wrote:

> Not seen a response on the backports mailing list so subscribed to the
> cocci mailing list and reposting it.

Sorry to have missed seeing it.

>
> Attached is a script I want to use to backport drivers. However, the
> second (unnamed) rule matches for each occurence of 'struct
> net_device_ops'. Is there a way to disable a rule after a desired amount
> of matches (in my case once)?

Here is a somewhat clunky solution:

@initialize:python@
@@

first_ops = 0

@r@
identifier OPS;
position p;
@@

struct net_device_ops OPS at p = { ... };

@script:python depends on r@
@@

first_ops = 0

@script:python@
p << r.p;
@@

ln = int(p[0].line)
if first_ops == 0 or ln < first_ops:
  first_ops = ln

@script:python@
p << r.p;
@@

ln = int(p[0].line)
if not(first_ops == ln):
  cocci.include_match(False)

@r1 exists@
expression ndevexp, e1, e2;
identifier func;
@@
func(...) {
          <+...
-         ndevexp->min_mtu = e1;
-         ndevexp->max_mtu = e2;
          ...+>
}

@r2@
expression r1.e1,r1.e2;
identifier r.OPS;
@@
+ static int __change_mtu(struct net_device *ndev, int new_mtu)
+ {
+ if (new_mtu < e1 || new_mtu > e2)
+             return -EINVAL;
+             ndev->mtu = new_mtu;
+ }
+
struct net_device_ops OPS = {
       ...
};

@depends on r2@
identifier OPS;
@@

struct net_device_ops OPS = {
+      .ndo_change_mtu = __change_mtu,
       ...
};

-------------------------

Basically, the idea is to find the line number of the start of each
net_device_ops structure.  The first script:python rule initializes
first_ops for the current file.  The second one passes through the
position information for each net_device_ops structure and finds the
smallest line number.  The third python rule discards all matches that
don't have the name of the structure on the collected smallest line.  Rule
r1 then matches the two assignments, rule r2 puts the new function on top
of the earliest detected structure (determined by the inherited value of
OPS), and then the last rule added the field to the structure.

I noticed that there is a problem though when the structure is define
within a function.  Then the added function goes in that structure too.
The affected file is: drivers/tty/n_gsm.c.  Maybe you odn't want o
backport that one?

julia
