From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 17 Aug 2017 13:50:08 +0200 (CEST)
Subject: [Cocci] [PATCH] Coccinelle: add atomic_as_refcounter script
In-Reply-To: <1502884342-10702-2-git-send-email-elena.reshetova@intel.com>
References: <1502884342-10702-1-git-send-email-elena.reshetova@intel.com>
 <1502884342-10702-2-git-send-email-elena.reshetova@intel.com>
Message-ID: <alpine.DEB.2.20.1708171346010.3748@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> +identifier fname =~ ".*free.*";
> +identifier fname2 =~ ".*destroy.*";
> +identifier fname3 =~ ".*del.*";
> +identifier fname4 =~ ".*queue_work.*";
> +identifier fname5 =~ ".*schedule_work.*";
> +identifier fname6 =~ ".*call_rcu.*";

Personally, I find the above regular expressions much easier to understand
than the merged version that Markus proposed.  But the performance issue is
only on whether to use regular expressions or not.  If you use regular
expressions, Coccinelle will not do some optimizations.  But once you
decide to use regular expressions, the performance hit is already taken -
for a good cause here, to my understanding.  So just put whatever you find
convenient, in terms of readability, precision, etc.  It seems that del is
not very precise, because it is a substring of multiple words with
different meanings.  Maybe it should be improved, or maybe one can just
live with the false positives (eg delay), if they actually are false
positives.

julia
