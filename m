From: joe@perches.com (Joe Perches)
Date: Thu, 23 Nov 2017 15:30:01 -0800
Subject: [Cocci] [PATCH] net: usb: hso.c: remove unneeded DRIVER_LICENSE
	#define
In-Reply-To: <20171122171201.GA6528@kroah.com>
References: <20171117141939.GD17880@kroah.com>
 <1511370336.6989.100.camel@perches.com> <20171122171201.GA6528@kroah.com>
Message-ID: <1511479801.5308.6.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 2017-11-22 at 18:12 +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 22, 2017 at 09:05:36AM -0800, Joe Perches wrote:
> > On Fri, 2017-11-17 at 15:19 +0100, Greg Kroah-Hartman wrote:
> > > There is no need to #define the license of the driver, just put it in
> > > the MODULE_LICENSE() line directly as a text string.
> > > 
> > > This allows tools that check that the module license matches the source
> > > code license to work properly, as there is no need to unwind the
> > > unneeded dereference.
> > 
> > []
> > > diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
> > 
> > []
> > > @@ -76,7 +76,6 @@
> > >  
> > >  #define MOD_AUTHOR			"Option Wireless"
> > >  #define MOD_DESCRIPTION			"USB High Speed Option driver"
> > > -#define MOD_LICENSE			"GPL"
> > >  
> > >  #define HSO_MAX_NET_DEVICES		10
> > >  #define HSO__MAX_MTU			2048
> > > @@ -3288,7 +3287,7 @@ module_exit(hso_exit);
> > >  
> > >  MODULE_AUTHOR(MOD_AUTHOR);
> > >  MODULE_DESCRIPTION(MOD_DESCRIPTION);
> > > -MODULE_LICENSE(MOD_LICENSE);
> > > +MODULE_LICENSE("GPL");
> > 
> > Probably all of these MODULE_<FOO>(MOD_<BAR>) uses could be
> > simplified as well.
> 
> Agreed, I did that for a bunch of USB drivers, need to do it for others
> as well.

Here's a little perl and bash script that seems to do the right thing
---
--- /dev/null	2017-11-23 06:19:12.943046739 -0800
+++ single_use_module.pl	2017-11-23 15:23:11.729812156 -0800
@@ -0,0 +1,15 @@
+$/ = undef;
+my $var = $ARGV[0];
+my $file = $ARGV[1];
+print("var: <$var> file: <$file>\n");
+open my $fh, "<", $file or die;
+my $data = <$fh>;
+close $fh;
+$data =~ s/\n#[ \t]*define\s+$var\s+(.*)\n/\n/;
+my $string = $1;
+print("string: <$string>\n");
+$string =~ s/\s+\n//;
+$data =~ s~$var~$string~;
+open my $fh, ">", $file or die;
+print $fh $data;
+close $fh;

--- /dev/null	2017-11-23 06:19:12.943046739 -0800
+++ single_use_module.bash	2017-11-23 15:23:01.964676948 -0800
@@ -0,0 +1,25 @@
+#!/bin/bash
+git grep -P '\bMODULE_[A-Z]+\s*\(\s*[A-Z_]+\s*\)' $@ |
+    while read line ; do
+	file=$(echo $line | cut -f1 -d":")
+	define=$(echo $line | cut -f2- -d":")
+	var=$(echo $define | sed -r -e 's/^MODULE_[A-Z_]+\s*\(\s*//' -r -e 's/^([A-Z_]+).*$/\1/')
+
+	# see if the define exists in the file
+	count1=$(git grep -c -P "^\s*#\s*define\s+$var\s+" $file | cut -f2- -d":")
+	if [[ $count1 != 1 ]] ; then
+	    continue
+	fi
+
+	# see if the var exists twice (once in the #define, once in the use)
+	count2=$(git grep -c -P -w $var $file | cut -f2- -d":")
+	if [[ $count2 != 2 ]] ; then
+	    continue
+	fi
+
+	if [[ "${defline: -1}" == "\\" ]] ; then
+	    continue
+	fi
+
+	perl single_use_module.pl $var $file
+    done
