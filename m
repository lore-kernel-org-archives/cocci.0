From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 1 Feb 2017 21:35:31 +0100
Subject: [Cocci] Hunt for array users of roc_dointvec()
Message-ID: <20170201203531.GI24047@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I'm trying to hunt for users of the proc_dointvec() handler in
setups where more than one value is expected to be used. The way
this old API works is it lets you specifiy in a structure the
variables and the size of the variables. In the singular case the
size will be maxlen = sizeof(int). If an array is used a user
may use maxlen = 2*sizeof(int), or other things.

Since I am looking for unsigned int users of proc_dointvec() to later
consider converting them to proc_douintvec() I can just focus for now
when the is not maxlen = (unsigned int) or maxlen = sizeof(int), and then
manually review the cases. Unfrotunately I cannot seem to construct
grammar to query context for this.

Let's consider just trying to get context for the case where the size is
not  maxlen = sizeof(unsigned int). I tried this bug get no results:

virtual context

@ find_proc @
identifier ctls;
expression name;
@@

struct ctl_table ctls[] = {
	{
		.procname = name,
		.proc_handler = proc_dointvec,
	},
};

@ singular_ints @
identifier find_proc.ctls;
expression find_proc.name;
@@

struct ctl_table ctls[] = {
	{
		.procname = name,
		.maxlen = sizeof(unsigned int),
	},
};

@ array_ints depends on context && !singular_ints @
identifier find_proc.ctls;
expression find_proc.name, E;
@@

struct ctl_table ctls[] = {
	{
*		.procname = name,
*		.maxlen = E,
	},
};
