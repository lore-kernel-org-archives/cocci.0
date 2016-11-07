From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Mon, 7 Nov 2016 11:27:19 +0000
Subject: [Cocci] positional variable problem
Message-ID: <20161107112719.GA17686@osadl.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


Hi !

On LKML Philippe Reynes posted an API update for ethtools API for
the pcnet32 care, basically to replace deprecated {get|set}_settings 
by the new API calls {get|set}_link_ksettings.
see: http://lkml.org/lkml/2016/11/6/2

So the scanner for this is simple:

<snip>
@find exists@
identifier oldapi,cmd,dev;
position p;
expression E;
@@

*static int oldapi at p(struct net_device *dev, struct ethtool_cmd *cmd)
{
<+...
*mii_ethtool_gset(&E, cmd);
...+>
}

@script:python@
p << find.p;
@@

msg = "old ethtool API in use."
coccilib.report.print_report(p[0], msg)
<snip>

 The problem was in the API update - as the get and set basically have the
same prototype so the find function seems to trigger in both - the
"solution" is a bit brute force regex in the "mod" rule - which I 
basicall think should not be needed.

<snip>
@initialize:python@
@@
import re
g = re.compile('get_')
s = re.compile('set_')

@find1 exists@
identifier get,cmd,dev;
expression E;
@@
static int get(struct net_device *dev, struct ethtool_cmd *cmd)
{
...
mii_ethtool_gset(&E, cmd);
...
}

@find2 exists@
identifier set,cmd,dev,ret;
expression E;
@@

static int set(struct net_device *dev, struct ethtool_cmd *cmd)            
{
<...
ret = mii_ethtool_sset(&E, cmd);
...>
}

@script:python mod@
oldg << find1.get;
olds << find2.set;
newg;
news;
@@

// the problem here is that the prototypes of get and set
// are identical so we only can keep them appart with regex 
if g.search(oldg) != None:
	coccinelle.newg = oldg.replace("get_settings","") + "get_link_ksettings"
else: 
        cocci.include_match(False)
if s.search(olds) != None:
	coccinelle.news = olds.replace("set_settings","") + "set_link_ksettings"
else:
        cocci.include_match(False)

@updateget@
identifier find1.get,find1.cmd,find1.dev,mod.newg;
expression E;
@@

-static int get(struct net_device *dev, struct ethtool_cmd *cmd)
+static int newg(struct net_device *dev, struct ethtool_link_ksettings *cmd)
{
<...
- mii_ethtool_gset(&E, cmd);
+ mii_ethtool_get_link_ksettings(&E, cmd);
...>
}

@updateset@
identifier find2.set,find2.cmd,find2.dev,mod.news;
identifier ret;
expression E;
@@

-static int set(struct net_device *dev, struct ethtool_cmd *cmd)
+static int news(struct net_device *dev, const struct ethtool_link_ksettings *cmd)
{
<...
(
  ret =
- mii_ethtool_sset(&E, cmd);
+ mii_ethtool_set_link_ksettings(&E, cmd);
|
- return mii_ethtool_sset(&E, cmd);
+ return mii_ethtool_set_link_ksettings(&E, cmd);
)
...>
}

@ksettings@
identifier ops;
identifier mod.newg;
identifier mod.news;
expression E1,E2,E3;
@@

struct ethtool_ops ops = {
...,
-.get_settings           = E1,
-.set_settings           = E2,
...,
 .get_link		 = E3,
+.get_link_ksettings     = newg,
+.set_link_ksettings     = news,
...,
};
<snip>

Is there a more resonable solution to this ?
it seems to be working correctly but I did not see the need to
actually use regex if the get and set fuction should be differenciateable
by the calls in the body (mii_ethtool_gset vs. mii_ethtool_sset) but
I could not get it to work on that basis.

The original attempt that fails due to the position collision (atleat that
is what I assume that is happeining) is below - the two lines in the 
@updateset@ rule will trigger the problem if uncommented.
giving:

Fatal error: exception Failure("meta: semantic error: position cannot be inherited over modifications: p
 =File "eth.cocci", line 63, column 16,  charpos = 1123
    around = ';', whole content = position find2.p;
")

find1 and find2 with the respective update functions seem to be ok if they
are put in seperate files. So the spatch that causes this is:

<snip>
@find1 exists@
identifier get,cmd,dev;
position p;
expression E;
@@
static int get at p(struct net_device *dev, struct ethtool_cmd *cmd)
{
<+...
mii_ethtool_gset(&E, cmd);
...+>
}

@find2 exists@
identifier set,cmd,dev,ret;
position p;
expression E;
@@

static int set at p(struct net_device *dev, struct ethtool_cmd *cmd)            
{
<+...
(
ret = mii_ethtool_sset(&E, cmd);
|
return mii_ethtool_sset(&E, cmd);
)
...+>
}

@script:python mod@
oldg << find1.get;
olds << find2.set;
newg;
news;
@@

coccinelle.newg = oldg.replace("get_settings","") + "get_link_ksettings"
coccinelle.news = olds.replace("set_settings","") + "set_link_ksettings"

@updateget@
identifier find1.get,find1.cmd,find1.dev,mod.newg;
position find1.p;
expression E;
@@

-static int get@p(struct net_device *dev, struct ethtool_cmd *cmd)
+static int newg(struct net_device *dev, struct ethtool_link_ksettings *cmd)
{
<...
- mii_ethtool_gset(&E, cmd);
+ mii_ethtool_get_link_ksettings(&E, cmd);
...>
}

@updateset@
identifier find2.set,find2.cmd,find2.dev,mod.news;
identifier ret;
// the position causing the problem
//position find2.p;
expression E;
@@

//-static int set at p(struct net_device *dev, struct ethtool_cmd *cmd)
-static int set(struct net_device *dev, struct ethtool_cmd *cmd)
+static int news(struct net_device *dev, const struct ethtool_link_ksettings *cmd)
{
<...
(
  ret =
- mii_ethtool_sset(&E, cmd);
+ mii_ethtool_set_link_ksettings(&E, cmd);
|
- return mii_ethtool_sset(&E, cmd);
+ return mii_ethtool_set_link_ksettings(&E, cmd);
)
...>
}

@ksettings@
identifier ops;
identifier mod.newg;
identifier mod.news;
expression E1,E2,E3;
@@

struct ethtool_ops ops = {
...,
-.get_settings           = E1,
-.set_settings           = E2,
...,
 .get_link		 = E3,
+.get_link_ksettings     = newg,
+.set_link_ksettings     = news,
...,
};
<snip>

thx!
hofrat
