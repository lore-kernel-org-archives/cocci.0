From: mmarek@suse.cz (Michal Marek)
Date: Wed, 03 Jul 2013 16:04:33 +0200
Subject: [Cocci] [PATCH 3/3] Coccinelle: Update the options used to the
 new option scheme
In-Reply-To: <CAAxaTiMgaCp17um0NnF2gbWDoRZnb2GOq-50LRAvV_dDdEsjRg@mail.gmail.com>
References: <1371726656-24928-1-git-send-email-nicolas.palix@imag.fr>
 <1371726656-24928-2-git-send-email-nicolas.palix@imag.fr>
 <51D428F4.6020003@suse.cz>
 <CAAxaTiMgaCp17um0NnF2gbWDoRZnb2GOq-50LRAvV_dDdEsjRg@mail.gmail.com>
Message-ID: <51D42F71.9030701@suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 3.7.2013 15:52, Nicolas Palix wrote:
> Hi,
> 
> On Wed, Jul 3, 2013 at 3:36 PM, Michal Marek <mmarek@suse.cz> wrote:
>> On 20.6.2013 13:10, Nicolas Palix wrote:
>>> spatch has changed its option scheme.
>>> E.g., --no_show_diff is now --no-show-diff
>>>
>>> This patch updates:
>>>  - scripts/coccicheck
>>>  - Semantic patches under scripts/coccinelle/
>>
>> Will the new syntax work with older spatch versions?
>> I mean, it's
>> probably fair to require a recent version, but it should be documented IMO.
> 
> It is the opposite. The new spatch still supports the old
> naming scheme. The more conventional naming has been introduced
> in spatch version 1.0.0-rc11 in March 2012. I will send a new patch to
> document that point.

Thanks.


>> Also, there was no patch 2/3 in this series, only 1/3 and 3/3.
> 
> It seems you finally found the v2 of this one. :)

Yes :).

Michal
