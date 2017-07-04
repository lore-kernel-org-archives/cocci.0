From: okuznik@symas.com (=?utf-8?B?T25kxZllaiBLdXpuw61r?=)
Date: Tue, 4 Jul 2017 18:46:33 +0100
Subject: [Cocci] Matching format strings
In-Reply-To: <WM!6445a14b41a047e62e6e93d9a0da969d5ea2daf83555655349684d54f3d26f5ca8795d092a053f4ee93c2a22f577a788!@mailstronghold-1.zmailcloud.com>
References: <WM!e764e7a6685d1e3af9c59f905772f1c4a8db9db4c655054ccb07f1b8485096c0979716269a6920eeac860b62d25a700e!@mailstronghold-2.zmailcloud.com>
 <20170704160123.lilble53tmv5t5va@eos.mistotebe.net>
 <alpine.DEB.2.20.1707041806150.11588@hadrien>
 <WM!cc508729d042cf12207adee814670b88c105ae73cdaf601fdeb9c3e26fa32e7df0d4d49f847a216810550421de0d8de6!@mailstronghold-3.zmailcloud.com>
 <20170704162732.urhtl54j3gbj3myh@eos.mistotebe.net>
 <alpine.DEB.2.20.1707041837300.11588@hadrien>
 <WM!eb7db9be9e260b8b332afe997cbb4412d355372680c68c06376375f785c138afeda43804b4aaff43c0242a17ff2d826f!@mailstronghold-3.zmailcloud.com>
 <20170704165655.yu7wwg7aomihs4of@eos.mistotebe.net>
 <alpine.DEB.2.20.1707041858400.11588@hadrien>
 <WM!6445a14b41a047e62e6e93d9a0da969d5ea2daf83555655349684d54f3d26f5ca8795d092a053f4ee93c2a22f577a788!@mailstronghold-1.zmailcloud.com>
Message-ID: <20170704174632.v7ibsesdtquktbjs@eos.mistotebe.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jul 04, 2017 at 06:59:39PM +0200, Julia Lawall wrote:
>>> How about adding a timeout (eg --timeout 120) and then see how much is
>>> left over.
>>
>> I get:
>> timeout (we abort)
>> Fatal error: exception Common.Timeout
>>
>> and no patch is produced, if I wait the 1028 seconds, I get the expected
>> patch. I think that supports your hypothesis about trying to process the
>> continue.
> 
> If you run Coccinelle on the whole directory, it should timeout on some
> files, and then work on the other ones.  Indeed, if there is a timeout at
> one point for a file then you won't get any patch for that file at all.

Ah, OK, I understand the suggestion now. It does speed up the initial
testing of the patch over the codebase.

Looking at some of the code (well, comments rather), coccinelle is
building a CTL formula and a state machine for the C file and tries to
find the states where it matches? Is that correct?

Does it try to compress the state machine based on the predicates
involved? BDDs tend to be rather helpful with CTL model checking. Not
sure how useful that is, depending on the information that needs to be
extracted (and I've not touched model checking in ages).

Sorry if this is completely wrong.

I vaguely remember seeing something like this somewhere, but can't find
it anymore. That might simplify the three-pronged construction I use
into a single patch hunk like the below. Is there a construction like
that available or have I just dreamed that up?

@@
(stuff here also contains format1, format2, args_before and others as
usual)
identifier merged : python merge_formats(format1, format2, args_before);
@@

-snprintf( buf, E, format1, args );
-Debug( L, format2, args_before, buf, args_after );
+Debug( L, merged, args_before, args, args_after );

-- 
Ond?ej Kuzn?k
Senior Software Engineer
Symas Corporation                       http://www.symas.com
Packaged, certified, and supported LDAP solutions powered by OpenLDAP
