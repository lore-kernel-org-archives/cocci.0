From: mmarek@suse.cz (Michal Marek)
Date: Mon, 25 May 2015 16:24:03 +0800
Subject: [Cocci] [PATCH] coccinelle: irqf_oneshot.cocci: Improve the
 generated commit log
In-Reply-To: <CAD3Xx4KJcfknCCvBgO1zte2q+KLjJ1mfR82ixx=Ejwc1P8xmow@mail.gmail.com>
References: <1432500354-10562-1-git-send-email-festevam@gmail.com>
 <alpine.DEB.2.02.1505250820520.2045@localhost6.localdomain6>
 <CAD3Xx4KJcfknCCvBgO1zte2q+KLjJ1mfR82ixx=Ejwc1P8xmow@mail.gmail.com>
Message-ID: <5562DC23.8000805@suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dne 25.5.2015 v 14:30 Valentin Rothberg napsal(a):
> On Mon, May 25, 2015 at 8:21 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>> Valentin?  (It's his semantic patch)
>>
>> julia
>>
>> On Sun, 24 May 2015, Fabio Estevam wrote:
>>
>>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>>
>>> Improve the commit log of the generated patch by mentioning the commit
>>> log that makes threaded IRQs without a primary handler to be requested
>>> with the IRQF_ONESHOT flag.
>>>
>>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> Acked- by: Valentin Rothberg <valentinrothberg@gmail.com>

Thanks, applied to kbuild.git#misc.

Michal
