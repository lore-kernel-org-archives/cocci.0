From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 15 Nov 2016 13:38:52 +0100 (CET)
Subject: [Cocci] Help in interpreting results
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612B41C00A21@IRSMSX102.ger.corp.intel.com>
References: <2236FBA76BA1254E88B949DDB74E612B41C009A9@IRSMSX102.ger.corp.intel.com>
 <alpine.DEB.2.10.1611151215240.3153@hadrien>
 <2236FBA76BA1254E88B949DDB74E612B41C00A21@IRSMSX102.ger.corp.intel.com>
Message-ID: <alpine.DEB.2.10.1611151335540.3153@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> So, "Skipping" means "not a single search token was found in file", "Handling" (without result print) means "one or more tokens were found, processing was done, but rule search pattern wasn't detected".
> I was just trying to understand how it works underneath. Thank you again!

Exactly.

You may want to run coccinelle/scripts/idutils_index.sh in your code base.
Then if you use the argument --use-idutils it will select the relevant
files up front from the index and be even more efficient.  Skipping means
that it essentialy did a grep and didn't find anything.  If the argument
after --use-idutils does not begin with -, it will think that it is the
name of the index.  The easiest is to just put --use-idutils last.

julia
