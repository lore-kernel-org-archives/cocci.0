Return-Path: <SRS0=yhX/=IB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A06C433DB
	for <cocci@archiver.kernel.org>; Wed,  3 Mar 2021 10:08:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306D164E42
	for <cocci@archiver.kernel.org>; Wed,  3 Mar 2021 10:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306D164E42
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=prevas.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 123A8XbX001214;
	Wed, 3 Mar 2021 11:08:33 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5874677CC;
	Wed,  3 Mar 2021 11:08:33 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 61B87571B
 for <cocci@systeme.lip6.fr>; Wed,  3 Mar 2021 10:42:02 +0100 (CET)
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50139.outbound.protection.outlook.com [40.107.5.139])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1239g1KU029991
 for <cocci@systeme.lip6.fr>; Wed, 3 Mar 2021 10:42:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQ6sOS5M2O9ZICsJwCwUyepIFgy99GxLiqSGpDy7eVim8nDiM5jQaNjsdRYBbPHc8ohKuhaMMOVFPyqZqBLp8wJiw+SPlI5auvvk0pxkBzng9nwSmz2c16pn+41aNCvfWeA0i32swmnef1bNtluqvYb2FkuVAyoqzQCttxTHSg8PLY3xurXJCj5wsIj6+GCDm/q1Sy4RbpuwZvtHs3zR/GeRYRxLLJPhWOSVGvT2o8FfFKhRtKFeYZksqI+gMIjP9abB27ut9NoaNLV+5yuEe1whnA3M+yFVVhbFi0fGGdxbW2tryJm8SLqeb7wKOCKm2ya09QjGsnwfBAlJnEGjxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVQAVJ031Cb7wdkUng1Tmlxs7gJZDXcs8oAoO3D3K8g=;
 b=mQuHFMrnursbADUOxGfc0vq5zlcGOw+nw502I0t0rAlnYbyyrvt1KDYB1o2BTw2DETfbZW4gB1LQyhqAWfOL6My+JnxtXaEcVfTKWPbTCaJf1iRIKzCepHGoHfRNsNPRuWqe9BrC5iKTsyShCqan069hQ4zEPN8fy0SqCWDGObxJLu8oAwVxVFLfpvaOBSw+GVM45cNSPOozr816Pb2siohxAMI3oD+dzP+s0RhSXkHUJ++U08LgwyEXPwr/vvbT9IAazcGBtXT3/MoufuCgndCbrJCIxYcF9Wb/DK1GTb5Y5vgXyDA6MVj8RvloVqOgac3MjeOTMzjV//i8fSJH5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVQAVJ031Cb7wdkUng1Tmlxs7gJZDXcs8oAoO3D3K8g=;
 b=RmEsWVyIsLlXcE77NAxgR8JvQ+/JHsGgYeDJtU6PhWzmD6flUsvScJtAav5sPWOViJQ6BjCjg3ExSphbINX3AiS3C5Lbnk20fykxbathkI5yITSU7EKPnllGzi4nkR75Tylh8r62wmjspONA/VDxwXcREj0pimfVG+hcCJoYC8Q=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM9PR10MB4434.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:273::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 09:42:00 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::58b2:6a2a:b8f9:bc1a]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::58b2:6a2a:b8f9:bc1a%3]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 09:42:00 +0000
To: Joe Perches <joe@perches.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        cocci <cocci@systeme.lip6.fr>
References: <053b06c47f08631675c295b5c893b90be4248347.camel@perches.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <a15e5c4d-a60f-14b9-90e5-4e600771aa9d@prevas.dk>
Date: Wed, 3 Mar 2021 10:41:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <053b06c47f08631675c295b5c893b90be4248347.camel@perches.com>
Content-Language: en-US
X-Originating-IP: [80.208.71.141]
X-ClientProxiedBy: AM7PR03CA0028.eurprd03.prod.outlook.com
 (2603:10a6:20b:130::38) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (80.208.71.141) by
 AM7PR03CA0028.eurprd03.prod.outlook.com (2603:10a6:20b:130::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Wed, 3 Mar 2021 09:41:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02359cbe-8db0-4dce-567e-08d8de289746
X-MS-TrafficTypeDiagnostic: AM9PR10MB4434:
X-Microsoft-Antispam-PRVS: <AM9PR10MB44346AE4D5FA2A1EA4F9AB3393989@AM9PR10MB4434.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xoVXVGjgqBYZSmLpaneyWzrv56AO3zXbWW2IgjbiCm+MaPiu1kKMlri4LvAvFlaIHNyVzcToFFEShLYXeP8+YVl2ElSOvVqsRiAhpU9uX6zwz/m89Ej0XBEMNGLCuSEFL88xVl/mvfdPf9pLMo7jQlfWhCBxkCri6nBGILFudHwd36L/Cx4Z9KchlPGiiHwCKll1HpSJoC8W/wCItnfD3XbBVlcvmwqS7yRKghm3/ENuRdlng6HGvPS/aeIxl+zHMdAqE33ZrX9cLYwWadiCxNw2WWebeFifUif3uZ17DPDvdzPBRuP8M2hhjsbzFjjvhbFguBG8y6xXfUrYlaVShsfyQmC0qC89xzJar/nLpBEmik0ZBdrCVNi2RGjHyc4VLxAXovfVdENFkP12LOq/WlLCTXHFSy5C8fjlF2PUeYC4p+XYOUFn5T+mcq6k+1T6Suyz7gGGidqC6RZiI9F13VbgEq19ss1t9OaALg5OLHlwgpV5G8bpEwAUYXafYoRPg9qPGiRbNBccDo4cjRJBhxMmN1miQVCtIgFR6QxBlsS372+khy/mFcbgWUkOiO0L6eyu7WLfyuhkvF1zUBIJeWA1zsSKYicJ3jhnoqZOltk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(396003)(39840400004)(136003)(346002)(366004)(376002)(6486002)(4326008)(8976002)(2616005)(66556008)(31696002)(478600001)(956004)(2906002)(66476007)(44832011)(8676002)(86362001)(186003)(66946007)(16526019)(316002)(16576012)(110136005)(26005)(8936002)(31686004)(36756003)(5660300002)(52116002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?hYjfE05RghZFz/xpR7p4dhXm1Wk0mazRrxRucjQYGu72aSt7ewJTQ3Mj?=
 =?Windows-1252?Q?VgWs4tXb4+MJ8SsVMA1Jm4T1iBH1EN0aUsu0KXagJp4T5/DvZHYTWi/8?=
 =?Windows-1252?Q?YhBbxNMn/d4c0fAdE2u2Z+TaoeNQbndPzkp9SWynBSQwZxbyfPtlEcg3?=
 =?Windows-1252?Q?S8XwlVf35aOdTD1six4rdgN9HfLr/SOygrppy99/bdGkRjVyYGlpqa5+?=
 =?Windows-1252?Q?dT28YMtE2rKKXUhYhpx5G+7CWY9k+TjTAjlhHkoOWDPQzfrOHFQ8JMp2?=
 =?Windows-1252?Q?atNwH3Z7KWGuaS6EmHe1EckfT5nWUI3REPS4NTnPrKVPZMX/247HPD0W?=
 =?Windows-1252?Q?7PrF1E9w2BYi79445AyK3qUWKI10GqJ5/ih8l8qgbKkCMszjqNdMwkAx?=
 =?Windows-1252?Q?/aAnI0LqJfanxk5ZiwVuoAPuYkIeA28wdeWSFT+N1Qmujkg4h4LhIUP+?=
 =?Windows-1252?Q?U9LJ8wQRUppsM7br7WLs/UgW/31Y7ZGzBMtovZi4EL1oFp9uGC9u2HED?=
 =?Windows-1252?Q?wpSpZNetIRIE9iftKlxPq4LtaFnK8kNZbzX7kwyHIzQQkZtdcQdHlGrv?=
 =?Windows-1252?Q?K/JDCWfg0wclVpn8M0ygpmhjKh2zr2stTdSQ4X4pO+b/Wr0HoZ2UT3t8?=
 =?Windows-1252?Q?t45tUcWphqXnPOeo7YG5h+N2o0tU3WqSqkUxx1r2Rq7ep/59hwsJ0nKq?=
 =?Windows-1252?Q?1uP4WoZnANpEaXqgPDvA4TDodrFmtdE8/a1a78OsgVbMcOJWUiDcVcPo?=
 =?Windows-1252?Q?Kd9RbooaAtCUZDWGe+IbbPWzQ20q99E6U182wEG9VQazp2X0tUEIojZU?=
 =?Windows-1252?Q?vD/H85HnNat/HrHvO31Wj2LIbXOy5rFs5sPXWrwaGMOR/ij+fVUJqg/b?=
 =?Windows-1252?Q?+CxlF9MxEoO1xhHVxzaFY2d5jOeT28bm/bN39wNyGnjX07ojugZecptQ?=
 =?Windows-1252?Q?Z6inp/7p7lnWycFa4JfQFuSppmHUpSqpACfhxTom3QqjDloSixlZchGR?=
 =?Windows-1252?Q?fYG8IlF7rq/84kI3YXkbrhnFV5d1QwPoEIhvEdBOr8Q+3SERCWadgdXL?=
 =?Windows-1252?Q?OHfgaq3Nc8iIGzyKIwHe3/Tn8EgEartxAp3EyaYtmeqVCKnJvEesrxyL?=
 =?Windows-1252?Q?FSOAcfW01v+iwVTZGx6B/QFwA7Gts7sACk3jDtHHM7bSH7hbsPC+SOtV?=
 =?Windows-1252?Q?C0V/iJmZpCnxuJGXNS3DyCIazGOAOZEWmk7pnt3OiW2R68igs/3K+qH/?=
 =?Windows-1252?Q?gZkN58U4QmvcYn0sFqAebuWoK0gXtmCLOi8Pf/fblgBU6slYJzrjXGdA?=
 =?Windows-1252?Q?RuHy/cP8gvFkZKyFfij9mUjh21dNLS2qEpndbi8TW1yODENTrJmb8fsN?=
 =?Windows-1252?Q?JRDj+CXtYyykyTs/fKPwmAe/bVPS4z0/EGj/hNt1zX82HdetLHi7jNmG?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 02359cbe-8db0-4dce-567e-08d8de289746
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 09:42:00.0737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTrsoZCTZo7/6eHrGSaljaoIFIb/2Rg301gLFf826TmDnop/USk/03J6MZqmiZBjTIl6dcEppFL5xo/7826m4RFVDfTU+JRK2+y32Dywk1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4434
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 03 Mar 2021 11:08:34 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 03 Mar 2021 10:42:01 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Wed, 03 Mar 2021 11:08:32 +0100
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Cocci] linux-kernel janitorial RFP: Mark static arrays as const
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

On 02/03/2021 18.42, Joe Perches wrote:
> Here is a possible opportunity to reduce data usage in the kernel.
> 
> $ git grep -P -n '^static\s+(?!const|struct)(?:\w+\s+){1,3}\w+\s*\[\s*\]' drivers/ | \
>   grep -v __initdata | \
>   wc -l
> 3250
> 
> Meaning there are ~3000 declarations of arrays with what appears to be
> file static const content that are not marked const.
> 
> So there are many static arrays that could be marked const to move the
> compiled object code from data to text minimizing the total amount of
> exposed r/w data.

You can add const if you like, but it will rarely change the generated
code. gcc is already smart enough to take a static array whose contents
are provably never modified within the TU and put it in .rodata:

static int x = 7;
static int y[2] = {13, 19};

static int p(int a, const int *foo)
{
	return a + *foo;
}
int q(int a)
{
	int b = p(a, &x);
	return p(b, &y[b & 1]);
}
$ nm c.o
0000000000000000 T q
0000000000000000 r y
$ size c.o
   text    data     bss     dec     hex filename
    111       0       0     111      6f c.o

So x gets optimized away completely, but y isn't so easy to get rid of -
nevertheless, it's never modified and the address doesn't escape the TU,
so gcc treats is as if it was declared const.

I think you'll see the same if you try adding the const on a few of your
real-life examples. (Of course, the control flow may be so convoluted
that gcc isn't able to infer the constness, so I'm not saying it will
never make a difference - only that you shouldn't expect too much.)

Rasmus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
