From: mstefani@redhat.com (Michael Stefaniuc)
Date: Sat, 10 Dec 2016 00:31:37 +0200
Subject: [Cocci] Negated Positions and Modifications
In-Reply-To: <ow4vaut9wui.fsf@mbp-thierry.rsr.lip6.fr>
References: <6772dc00-a196-b6db-097e-f4be53ff7d87@redhat.com>
 <alpine.DEB.2.10.1611221430450.31331@hadrien>
 <93d3068e-44a6-c80a-ecb3-6290d985a559@redhat.com>
 <alpine.DEB.2.20.1611272159200.2019@hadrien>
 <alpine.DEB.2.20.1611292248140.2016@hadrien>
 <8338824e-3099-6e7b-f9a1-431f829f3c00@redhat.com>
 <alpine.DEB.2.10.1612081420220.7563@hadrien>
 <ow4vaut9wui.fsf@mbp-thierry.rsr.lip6.fr>
Message-ID: <5548da91-3a5a-9952-4b5a-6b1ecd43c8a9@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 12/09/2016 01:16 PM, Thierry Martinez wrote:
> Julia :
>> It should be possible.  I'll check with Thierry about it.
> 
> It is now possible (with the version pushed to Github master).
Thanks Thierry,

it works nicely and I've deduplicated some more rules.

But I'm getting a new warning that I wasn't getting before:
  warning: r3: metavariable T not used in the - or context code

The exact same rule r4 that just uses type r.T does not produce that
warning. Simplified test rules attached.

I don't mind too much as the code works but I thought it is worth
mentioning.

bye
	michael
-------------- next part --------------
@r1@
type T;
@@
 T foo;


@r2@
type T;
@@
 T bar;


@r3@
type T = {r1.T, r2.T};
identifier fn;
@@
 fn(...) {
+  T foobar;
   ...
 }


@r4@
type r1.T;
identifier fn;
@@
 fn(...) {
+  T foo;
   ...
 }
