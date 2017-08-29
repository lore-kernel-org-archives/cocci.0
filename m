From: elena.reshetova@intel.com (Reshetova, Elena)
Date: Tue, 29 Aug 2017 09:01:52 +0000
Subject: [Cocci] [PATCH] Coccinelle: add atomic_as_refcounter script
In-Reply-To: <alpine.DEB.2.20.1708171346010.3748@hadrien>
References: <1502884342-10702-1-git-send-email-elena.reshetova@intel.com>
 <1502884342-10702-2-git-send-email-elena.reshetova@intel.com>
 <alpine.DEB.2.20.1708171346010.3748@hadrien>
Message-ID: <2236FBA76BA1254E88B949DDB74E612B6FF5F9CA@IRSMSX102.ger.corp.intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> > +identifier fname =~ ".*free.*";
> > +identifier fname2 =~ ".*destroy.*";
> > +identifier fname3 =~ ".*del.*";
> > +identifier fname4 =~ ".*queue_work.*";
> > +identifier fname5 =~ ".*schedule_work.*";
> > +identifier fname6 =~ ".*call_rcu.*";
> 
> Personally, I find the above regular expressions much easier to understand
> than the merged version that Markus proposed.  

I really don't have a strong opinion on the presentation side. 
One is more compact, the above one perhaps a bit clearer for unexperienced reader (like myself). 
Sometimes when I try to read patterns from cocci folder,
it takes me really a while to understand what is happening, which is not the case
with simple expression above. I have just considered myself to be too new into this
and therefore sticked to simple expressions to make sure I am minimizing functional mistakes. 

But the performance issue is
> only on whether to use regular expressions or not.  If you use regular
> expressions, Coccinelle will not do some optimizations.  But once you
> decide to use regular expressions, the performance hit is already taken -
> for a good cause here, to my understanding.  

Ok, so then performance is not even a factor. Thank you for the explanation! 

So just put whatever you find
> convenient, in terms of readability, precision, etc.  It seems that del is
> not very precise, because it is a substring of multiple words with
> different meanings.  Maybe it should be improved, or maybe one can just
> live with the false positives (eg delay), if they actually are false
> positives.

This is the problem that some of them might be and some not. 
I can call the queuing works explicitly:
identifier fname4 =~ ".*queue_work.*";
identifier fname5 =~ ".*queue_delayed_work.*";

Then there is no need to match "delay", but I still like to match both "delete" and "del". 

Best Regards,
Elena.
> 
> julia
