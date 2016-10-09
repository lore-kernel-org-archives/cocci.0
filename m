From: Nikolaus@rath.org (Nikolaus Rath)
Date: Sun, 09 Oct 2016 13:38:10 -0700
Subject: [Cocci] Usage of "expressions" and "identifiers" with SmPL
In-Reply-To: <83aae471-2eda-6ae0-9340-8e39bd214542@users.sourceforge.net> (SF
 Markus Elfring's message of "Sun, 9 Oct 2016 09:49:52 +0200")
References: <87r37vzd8j.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610050744460.3061@hadrien>
 <87shsa7p71.fsf@thinkpad.rath.org>
 <alpine.DEB.2.10.1610052158110.3130@hadrien>
 <8760p6ctgw.fsf@thinkpad.rath.org>
 <alpine.DEB.2.10.1610060750180.3179@hadrien>
 <878ttzjzss.fsf@vostro.rath.org>
 <20a829ad-af8d-ee46-8e61-8ba06098c1f5@users.sourceforge.net>
 <alpine.DEB.2.10.1610080850470.7750@hadrien>
 <1f88759f-f167-fcea-5c93-b8e13d7a858b@users.sourceforge.net>
 <alpine.DEB.2.10.1610080954130.7750@hadrien>
 <4faf71af-49b2-237a-edac-d8841de28cba@users.sourceforge.net>
 <alpine.DEB.2.10.1610081029050.7750@hadrien>
 <3bbf1a67-5fae-7d34-d39c-b3820082441d@users.sourceforge.net>
 <87zimey49q.fsf@vostro.rath.org>
 <83aae471-2eda-6ae0-9340-8e39bd214542@users.sourceforge.net>
Message-ID: <87zimdz2a5.fsf@vostro.rath.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Oct 09 2016, SF Markus Elfring <elfring@users.sourceforge.net> wrote:
>> The only effect your emails had on me was a big "WTF!?".
>
> All of them (including the provided small SmPL script examples on
> 2016-10-05)?

You wrote three emails on that day. I assume you mean this one?

,----
| > 2. ..and how would I go about if instead of the type, I want to replace
| >    a variable name? (my_type *ptr --> my_type *pointer).
| 
| Would you like to try another small SmPL script out like the following?
| 
| 
| @name_replacement@
| @@
|  my_type *
| -ptr
| +pointer
|  ;
| 
| 
| How will your software development experiments evolve for the desired
| application of the semantic patch language?
`----

I'm afraid the answer is yes. Even though the snippet was relevant, its
presentation triggered the same WTF effect.


>>> Would you like to start another marketing project?
>> 
>> What's the point of all these random questions that you bring up in
>> response to every sentence?
>
> Did you inspect any items from the GitHub issue tracker?
[...]

Well, I tried to make a point here., but it quite obviously failed
utterly.


Best,
-Nikolaus

-- 
GPG encrypted emails preferred. Key id: 0xD113FCAC3C4E599F
Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             ?Time flies like an arrow, fruit flies like a Banana.?
