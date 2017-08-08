From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 8 Aug 2017 20:34:01 +0200
Subject: [Cocci] add atomic_as_refcounter script
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612B6FF2E1DA@IRSMSX102.ger.corp.intel.com>
References: <2236FBA76BA1254E88B949DDB74E612B6FF2E1DA@IRSMSX102.ger.corp.intel.com>
Message-ID: <4454b236-64be-13cb-f85d-fa850619c7d6@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dear Elena,

I have also taken another look at your script.

The SmPL rule ?r1? specifies six metavariables for identifiers. It seems that
the names ?fname3? till ?fname6? do not care for different function parameters
in the SmPL disjunction at the end.
How do you think about to reduce this disjunction by using a regular expression
with an alternation like ?.*(?:call_rcu|del|queue_work|schedule_work).*?
for a constraint?

Will it help to refactor another rule a bit?

@r3 exists@
identifier x;
position p1;
@@
 x =
(
 atomic_add_return at p1(-1, ...);
|
 atomic_long_add_return at p1(-1, ...);
|
 atomic64_add_return at p1(-1, ...);
)


Regards,
Markus
