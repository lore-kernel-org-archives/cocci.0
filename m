From: cocci@junktrap.net (Anthony)
Date: Wed, 29 May 2013 14:57:51 +0200
Subject: [Cocci] python variable in spatch
In-Reply-To: <alpine.DEB.2.02.1305291222330.2246@hadrien>
References: <CAKGFgN1wM+9-ALpJ4QO1Y5_pjhXJdZWBBEgWesdsq64v+_1jpg@mail.gmail.com>
 <alpine.DEB.2.02.1305291222330.2246@hadrien>
Message-ID: <CAKGFgN3p6BLbeF86p-7mTp=H3z6=J88Q_d4ffmeyBx0Ln5O_9A@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, May 29, 2013 at 12:23 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> On Wed, 29 May 2013, Anthony wrote:
>
>> Hi,
>>
>> I would like to apply a semantic patch which will include some values
>> generated through a @script:python@ block, but I didn't succeed so
>> far.
>> e.g.: update variable names based on a csv file, parsed in a python block.
>> Any idea someone ?
>
> Did you take a look at demos/pythontococci.cocci ?
>
> If that didn't help, please send an example that causes problems.
>
> julia

It helped, I got something (almost) working now, thank you !

Anthony
