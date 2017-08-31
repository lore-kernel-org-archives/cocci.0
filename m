From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 31 Aug 2017 16:09:30 +0200 (CEST)
Subject: [Cocci] OpenLDAP debug statements
In-Reply-To: <20170831133724.psnilhftsv5wosmu@eos.mistotebe.net>
References: <20170829150811.xnttkxd47mknqzzn@eos.mistotebe.net>
 <alpine.DEB.2.20.1708292315050.5428@hadrien>
 <WM!749c3f172b3974a95a60915dcb92be0a7c29793379a0cf5b8c9fa31b26724555bb6748424359219db0307c72c35963de!@mailstronghold-1.zmailcloud.com>
 <20170829221532.ukkaxuvcgr7d25cn@eos.mistotebe.net>
 <alpine.DEB.2.20.1708300722580.2152@hadrien>
 <WM!d9b0a1156da6c99c9820ebef21a59a8a89d121069b7a3992c73cc9e3056bf05f3193ceae9e855747b5cba0f4c7a73e77!@mailstronghold-3.zmailcloud.com>
 <20170830125059.eqlq4w54oz57azum@eos.mistotebe.net>
 <alpine.DEB.2.20.1708301504210.3184@hadrien>
 <WM!31a93b9eaa05d271c5e490fb8cbf454d71a531b19f3453d107ecb7e19adb99d108c14ee93b5774c82e15694f7e635331!@mailstronghold-2.zmailcloud.com>
 <20170831133724.psnilhftsv5wosmu@eos.mistotebe.net>
Message-ID: <alpine.DEB.2.20.1708311602290.6822@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

The problem is in the rule shortcut_replace.  You have:

(
-{
-\( T buf = {...}; \| T buf = I; \| T buf; \| \)
-snprintf at p1( buf, E, format1, args );
-Debug at p2( L, format2, args_before, buf, args_after );
+Debug( L, merged, args_before, args, args_after );
-}
|
{
-\( T buf = {...}; \| T buf = I; \| T buf; \| \)
-snprintf at p1( buf, E, format1, args );
-Debug at p2( L, format2, args_before, buf, args_after );
+Debug( L, merged, args_before, args, args_after );
}
|
-\( T buf = {...}; \| T buf = I; \| T buf; \| \)
-snprintf at p1( buf, E, format1, args );
-Debug at p2( L, format2, args_before, buf, args_after );
+Debug( L, merged, args_before, args, args_after );
)

There are three case (1, 2, and 3).  Normally a disjunction like this
matches from top to bottom, ie if the first case matches the ohers are not
considered.  Here however the patterns don' all start matching at the same
node.  The first two do, ie at an {, but the third does not.  So the third
will match over top of what was matched by the previous ones.  So there
will b multiple matches, and Coccinelle would prefer to do nothing rather
than to do something inconsistent.

As far as I can see, there is no real difference between the cases.  It
could probably be easier to just put the third case, and then have some
other rules to clean up any kinds of {} that occur.

I think that it should also be possible to define a metavariable

initializer i;

And then replace

T buf = {...}; \| T buf = I;

by T buf = i;

julia
