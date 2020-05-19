Return-Path: <SRS0=x7/Q=7B=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C44C433DF
	for <cocci@archiver.kernel.org>; Tue, 19 May 2020 12:04:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACEEA207D3
	for <cocci@archiver.kernel.org>; Tue, 19 May 2020 12:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="E5PVntjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACEEA207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04JC4r0J015683;
	Tue, 19 May 2020 14:04:53 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 90A017559;
	Tue, 19 May 2020 14:04:53 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 168673DC8
 for <cocci@systeme.lip6.fr>; Tue, 19 May 2020 14:04:51 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04JC4lJD009925
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 19 May 2020 14:04:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589889886;
 bh=OuIIx17N+WOi1W586PLzTCbgyMmXORT7zwVh9zmZM5g=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=E5PVntjwlUXKIkED+PCYTJagFbxInwmSmuuht1kkLjUEFWrwzq42DWWSwF1v7QUd1
 v6HWVDU3tSA3PBV7MrhzAjRKqNxTgDlpuU9Q/9BnroTPoYBXemturo0fOCsKlnIWl4
 SDbDcxhzF910jkM/6U445Lrmtn43ZtPAWUyJDR/U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.146.173]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MPYNR-1jf9iR06Sn-004oLy; Tue, 19
 May 2020 14:04:46 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <4a677190-b494-138c-4782-eec033a77377@web.de>
 <alpine.DEB.2.21.2005181118540.2467@hadrien>
 <0a93e321-42de-3534-9c4a-d67132a1289e@web.de>
 <alpine.DEB.2.21.2005181217580.2467@hadrien>
 <8f3cbbd1-653e-ab2d-5a41-18eec00ae828@web.de>
 <alpine.DEB.2.21.2005181234210.2467@hadrien>
 <e3d5a92f-0c78-c1ca-47ab-d2bb2864efaa@web.de>
 <alpine.DEB.2.21.2005181248310.2467@hadrien>
 <5c451649-4077-e54c-e01d-6bdbc0d02046@web.de>
 <alpine.DEB.2.21.2005191321270.2503@hadrien>
 <9b764738-8c6d-b066-925e-03d26c5ed063@web.de>
 <alpine.DEB.2.21.2005191355060.2503@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <9b6676d0-8d4a-dc25-8714-a2d65a4697a0@web.de>
Date: Tue, 19 May 2020 14:04:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005191355060.2503@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:O0fy73HiLHjqkWwmscoQFacE2aLHhrJ2YIdbDElDrH15qbx1spm
 6t2oEouufzqRxkJ1vzF59ft+1kNCaGLNml1GoTG/UgSJrGgKjexZZ5O4GkyHgSpO06nU1ys
 RHfrxZ973SVlQMgZs+PG14LuAKpXdLHUaJjUDh/GSMbM+czZc8+JwfXsOZP4+IBfNWfc6c2
 IzvnuKTtoZsJhPlUPOdWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3iBsgQZtygU=:ynEIhrhKDkAj3Wi+s2Gu8W
 kpvw9kOHruM+tqTgeLw78Ftj0IIGJqlQt2+nXbwd4psOo4JkfUu1P4meo8lDphBjkK46R7YLr
 G1ebKCQcgn81QVX+EoNcohq7d5alhoM+2Iw6xp9t/As6OMTVRUMBXnPnZ2/mo6aVsdLM2pGOS
 G0gu2ZuovCmyolEE21oj3ZGMI+aFsrXsi5Ko7Z8nQufT6QcSfnVEKQrYHqSw5M+2i80tMOCZ6
 ku4+WkMCE7j5dqDXSBRkAFzal8WDeLPzO/8Fu8rMYtOqeqNV4/noSgN1UNK0ZhMRWRjWfTjjd
 IYrAIIQYmQ9P0DslMZ8xWHdoirQ2e2w4/5mjuzEc+w4FbFT7AzGNhAq703Apb0ajpSrkMn7wV
 AbTifk6sGbYyw9Rk0tYMeSdMm9/3fl478013S9tjnuXQwnye7xcBLcaMldilzj5oma21k+ncK
 sI/NYftAcec2b89Dh7usRV0WOEZSpNeQdnoRzExVLod+LKdJfxp9KmezeNLjqE5aegbrHCfbc
 E5hE+4Qa5+K+94rcn0m1U3vtuqbqvcg0pH3XpFwVE3tvQlYOR7dFS9pJcJF0eGA3ShXyD+vKR
 l+1Nq6TFS51sJi+fDiqFFIdhkOVCvBw+foDrGhlFw6JTu/GV2WUqIySQ+LTS65KvkWjqmtsFz
 /oUcjSo4t3ch+Kdm3yQ3+WWXUCKe9fhsAFt8K8QBv9cdY432IaQaqg9/KoEzjlkZ0TW1QBGIT
 tl3JRA5Jh3U8zup3H6Ds3hU5OJOfLI3w5CmDwrmlttumAlvAd5/izjfchV1LKk0bxNCpdmXOJ
 33nGwjI9rojiVHBbnMq3kcE5jd9JL1oOZBbx87lfWB+nfBBFYe7/x/p5WbbnI1etEQPpE/fdy
 IlN4Xdhw5Vc9RKzQlvwjC9G+iRtrq1Tlsly3T8wE29QOHF9MLZ8k25rFbP+rfqeG1HkLKMyRN
 VFajmpRfOsEZGpIaFdBtsyQ+qQmFN+9Ygy+3sAF5teC3bedcs6oCwdSgDkten+QAfoQ/HQ+u3
 k3Dms+fjPOjtlVx6gJSbWviPbOpHPXlYsGGZA1NLry+JuMgsszv93KJLe83VNmYq/aXrGnV+2
 oSG2k4R2nRVQKFXix+2nE612yqUFf3OEm8QUmziWR3tDcJh1f82uXR0aSEYjI6V66OYh3Yshb
 fGVvf8y7GMLb5eLGVlSKeBV8va2T5ljEHN5UH9/dqnLbrfUcktgPJavmjgUvVBkY6gxBLQkBb
 FvjjCORHucM1mToC8
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 19 May 2020 14:04:53 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 19 May 2020 14:04:47 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Chuhong Yuan <hslester96@gmail.com>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] How to match function calls in macros?
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

>>> If it is working on a function definition, it works only on that function definition.
>>
>> Does the position of the define directive influence this view?
>
> I believe that the #defines inside of other top-level definitions are ignored.

I find such a feedback surprising.

It seems that the clarification of desired software functionality can become
more interesting also with this information.
How will the supported software functionality evolve further
besides intra-procedural source code analysis?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
