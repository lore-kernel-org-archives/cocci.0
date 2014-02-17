From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 17 Feb 2014 09:31:09 +0530
Subject: [Cocci] [PATCH] scripts/coccinelle: Use PTR_ERR_OR_ZERO
In-Reply-To: <alpine.DEB.2.02.1402082111000.2017@localhost6.localdomain6>
References: <1390805482-25075-1-git-send-email-sachin.kamat@linaro.org>
 <CAK9yfHzotmve4R_o=i95ybPeEMe5cNyn_ZmRDryzZKYmeL-JYw@mail.gmail.com>
 <alpine.DEB.2.02.1402082111000.2017@localhost6.localdomain6>
Message-ID: <CAK9yfHyZXKHeApxPPqKsWGG5KaCfb7z48Jmew6NTuUycuBHU4g@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Michal,

On 9 February 2014 01:41, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
> On Thu, 6 Feb 2014, Sachin Kamat wrote:
>
>> On 27 January 2014 12:21, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> > PTR_RET is deprecated. Do not recommend its usage anymore.
>> > Use PTR_ERR_OR_ZERO instead.
>
> Signed-off-by: Julia Lawall <julia.lawall@lip6.fr>
>
>
>> >
>> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

I believe this patch would be going through your tree?

-- 
With warm regards,
Sachin
