From: wagi@monom.org (Daniel Wagner)
Date: Fri, 22 Jan 2016 15:32:12 +0100
Subject: [Cocci] Filter out field names
In-Reply-To: <alpine.DEB.2.10.1601211138470.2530@hadrien>
References: <56A0A94A.9070702@monom.org>
 <alpine.DEB.2.10.1601211138470.2530@hadrien>
Message-ID: <56A23D6C.3010607@monom.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

On 21.01.16 12:02, Julia Lawall wrote:
>> There are a bunch of problems, e,g. the hard coded type/names or the
>> WARN_ON() should be put in front of the dereferences but that is something
>> for later to improve. The main problem I face at this point is to filter
>> out the spin_lock() and spin_unlock() access. All my attempts didn't let
>> to the expected result. I think the best thing would be to match on the
>> type. So if 'f' is of type spinlock_t ignore it. Any ideas how this
>> could be expressed?
>
> Here is my suggestion (see below for explanations):

Thanks a lot for your help! It's a really appreciated. Unfortunately, I 
haven't found time to play with it because of some fights with 
paperwork. Hopefully I have time on Monday to continue with this work.

Have a nice weekend,
Daniel
