Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5FCC43334
	for <cocci@archiver.kernel.org>; Mon, 27 Jun 2022 02:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=xOZyz54bapplfevA6IoBBeOERMm6lF270gKiNU+5SS0=;
  b=RJjssql1LSdZjsAbqJ1M8wqR1KJrvaqJU3Ml9i1zl5zLCoMWPvNnnp0n
   3oDosPA/CS/hRlo3LNlE6gNttZ0o41Tq5yuhOLDqYNvdZF21t+RvC/SOe
   7ROAJJbUoKhGj/yu5zxV1tShUJQBiFBZqynxLCXMbH4Kpn5ziuzisgY7G
   o=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.92,225,1650924000"; 
   d="scan'208";a="42926132"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Jun 2022 04:07:21 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C7735E00CA; Mon, 27 Jun 2022 04:07:20 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8C14DE00BE
	for <cocci@sympa.inria.fr>; Mon, 27 Jun 2022 03:41:09 +0200 (CEST)
IronPort-SDR: 29BTt3RaxrP3SqiVIya5a2pghDS7UiPEKEns5IkVA1JGGo/XlcR8HL2i/1qaPeV9AI9gN82PJv
 Yg3VLmvLfgB1QfcP+6L0OW9XUnMUW3187PPi/y/YJx1AmhKNZB/Y41rteTxo/1Bq0vkvbs31JT
 sYynH9UPUj0t1KwjLN7Y2435FLmy9Cor0SuetiFI9ZbEfWwm3ZShb0Sj0cFLV8TNO+pv/5oejv
 VZYcgkzlzF4F1Ej2VdfRwBjR+CtAyQLGmU0tOC6VGb3tqX2/zPUIfM1qvL8pvtotycek8YLonv
 +UJfzoowo0jW1rzBo61Engkv
X-IPAS-Result: =?us-ascii?q?A0DOAgBLCblifyraVdFaHgEBCxIMQINzgVYvBAtEhE6RE?=
 =?us-ascii?q?IsvhxyMIwsBAwENQgQBAYUDAoVKAh0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgQEARMBAQ0LCQcICgcODgVgAWEDAUSBT4F0CwMxDYI1KQGDY?=
 =?us-ascii?q?wEBAQECARIRHQEbHQEDDAYFCwoDAgImAgIhAQERAQUBHAYTIoVAAQMNIwOeR?=
 =?us-ascii?q?oEEQoo4eoEVBReBAYIJBoRMChkoDWqBWQIHEn8shFKBTIEvhysnHIINgUuCd?=
 =?us-ascii?q?D6CIIV6gmUEjRGMEgEDBwMEBgUPAwMCIgECAUYjAQEKAgYGBAYDAQEGAwkCB?=
 =?us-ascii?q?AISAgIEBxcKEggUAwIGAh8FAQcFAwMSBgwRAQgGBgEEAgoBAgIFBQwDAREDA?=
 =?us-ascii?q?gYCBAQEGBQEAgQHBgIJCQcFFgsECgIWARsCBgwIAgICAgIEFAcBDQUCAgQPA?=
 =?us-ascii?q?gcGAwsCAwUHAwMEBwwEDA4BAwEHAQQFAw0EAQEGAgkDBQoCAQIDDAEBBwQIA?=
 =?us-ascii?q?QECAgkCAQQCBwECBQMCAwgDAgMDAgEBBBACAwQDBAIDAQUBBQMCBQEDAwIBA?=
 =?us-ascii?q?wMDAgEEAwYJCgQIAQQEAQEBEQIHBwIGAwMCAgICBQECDQECAQIEAwYGAgMUA?=
 =?us-ascii?q?QIEAQoBBQIDCQIHAwEBAgYFCgIHBQIHAgIEAQUDDQEDBQIDAQEDAwIEAQIBA?=
 =?us-ascii?q?QMIAQMCAwMCAgICBQIDAgICCQMEAQcDAgEBBAUBBAMBAgoEBAMEAgQCBwIHA?=
 =?us-ascii?q?gQHAgECBgMHBgEDAgEHAQEECgQDAwMBBwECBQICAwIGEgYHAgQBAwQECgICC?=
 =?us-ascii?q?wIHAQECAQEBAQIDAgcFDAEBAQMCAwYCBQICAQEDCAgDAgEEAQUDAQQFAwcCA?=
 =?us-ascii?q?QUGAgkDAwkDAQEFAQMBCQMDAwIJAwECDAQDCAMDAgMEAgICAgEDAgcFCAQBB?=
 =?us-ascii?q?AkCAgIBAgICBAIBAxoBAgMFAgIJCwEEAgIDAQMBAQIIBAkEAgMEAgEBAwIBA?=
 =?us-ascii?q?gIBBQIOBgEBAQECAwMBAgMBBgcCCAIzEwEDAwMCAgUCAgECAwICDQEBAQQCA?=
 =?us-ascii?q?QIBAgYBAwECAgMBAwECAgYCDAkCBwEFAwMCAgMBAQUPBQIEAgECBgUCAQEBB?=
 =?us-ascii?q?AEDBAQGAgIBAwMCDgIEAQQBAgEBIwMEAgMBAxcBAgECAwMDBAYHBQIBAhMBA?=
 =?us-ascii?q?gEBAQUBAgEBBAIEBAcKAwICBAMDBQEBAgMCAQEBBwwCAgITAhMDAQYBDgUUA?=
 =?us-ascii?q?wIEAgIBAgIKAwECAgEDAgkCAQIBBSADAQEPJAEBAgICAgMEBwIBBAYDDQICA?=
 =?us-ascii?q?QEBBQYNAwIDCAwCCQMCAQMFAQICAgQBAgQMCgECAgECBAUFAwIBCAQFDQUJC?=
 =?us-ascii?q?wEBAgEDCAQDEQIFAwUFAwMCAQoFAgMBAgEBAwQBAwQGAQECAwICAQYCAgEBA?=
 =?us-ascii?q?wMEAwECBgICBwIDAgEEAgMDAQEBBAICAgICAwMIAwIBCAcFAQYBAgEEAwICA?=
 =?us-ascii?q?QIHAQQBCQIBAwMFAwQBCgMPAwUDAQMDAhUKBQEFCAYJAgQFAgUDAgQCAwMCA?=
 =?us-ascii?q?ggDAgQDAg0DAgYDBAIIBA8HAgMCAgUCAgICAgUEAwECAgICAgIFAgQEAQUBA?=
 =?us-ascii?q?gICAQICAgQBAgIHBAIDAQMEDgMDBAICBwECAgEGAQIHAwECAQQDAQEEAgIEA?=
 =?us-ascii?q?QICBQIBAwEEAQMBAgYCBAMKAgIDAgICCAgDBAwJAgIDBQICBQEBBQYnAQEFZ?=
 =?us-ascii?q?Jp+gVISb4EHE5VrAY0gnVVrFUuCeIQblX2FfjGoZJZwkQyWIhAjEoFDgX5wL?=
 =?us-ascii?q?1KCN04BAgEBAQ0BAgEBAwECAQIJAQECjh2DcoprNzE7AgYLAQEDCY8BAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:yDgWKKktzaKeLUBVJB27+TPo5gxTIERdPkR7XQ2eYbSJt1+Wr1Gzt
 xIdW2mEb/iNazPzKd0kOtmw8UoDuZWEyYdgTFdprSA0EFtH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvykTrSs1hlZHWeIcg944f5Ys7N/09QAbeSRWVvX4
 4us+ZOHYzdJ5hYtWo4qw/LbwP9QlK+q0N8olgRWiSdj4TcyP1FMZH4uDfnZw0nQGuG4LcbmL
 wr394xVy0uCl/sb5nxJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwZG8P4whlkeydx
 /1xqsObcBdxMpbKp7U7WBZALgRmH/N/reqvzXiX6aR/zmXDenrohvhsVQQ4Ydde9eFwDmVDs
 /cfLVjhbDjZ37PwkO/9ELA8wJh5RCXoFNt3VnVIyCzVCvApRZHKRarD79RU9Dg1j8FKW/3ZY
 qL1bBI2M0SZO0QRYT/7DroTxvqwnTrfNAFdqXfWoLYFwCvt7i5Yhe2F3N39I4TWH625hH2wo
 mvZ9mD9KgMbMdaFwHyE9Gitj6nBh0vTU4UZH7yQ7e9vmFTVx2oJCRRQW0HTnBWioku3WtYaJ
 k5NvyRy9+4980ukStS7VBq9yJKZgvICc+ZPTMYD+FmB8azrsiCSCXA5ayZjNuVz4afaWgcW/
 lOOmtroAxlmv7uUVW+R+9+oQdWaaXh9wYgqNX9scOcV3zXwiNps0U+XH76PBIbw34KlQ2ihq
 9yfhHFm3+17sCId60msEbn6b9+Eo5HISks45FySUD7/qAx+Y4Ghasqj7l2zARd8wGSxHwHpU
 JsswZD2AAUy4XelynHlrAIlQuzB2hp9GGeA6WOD5aUJ+TW34GKEdotN+jx4L0oBGp9aJGGzP
 h+J414PucA70J6WgUlfM9LZ5yMCnfiIKDgZfq28gidmOcUuKFfcoEmCm2bJjzi8yyDAbp3Ty
 b/CKZr2ZZrrIatgyzWySo8gPUwDl0gDKZfobcmjlXyPiOLADFbMEOttGAbQM4gRsfzcyC2Io
 o43H5bbkH13DbyuCgGJq9J7BQ5RdhATW8umw/G7g8bZfWJOAn86MfbNzNsJI8o1wsy5YM+Tr
 i/jMqKZoXKj7UD6xfKiNig4M+yxDMoj8xrW/0UEZD6V5pTqWq73hI93Snf9VeBPGDVLwaEmQ
 v8bVd+HB/gTGD3L9y5MP5b4pY1mMh+sgFvWbSaiZTE+eb9mRhDIqoe0JFuxqHFWA3rlr9Y6r
 p2hyhjfHsgOSgFkO8DcN6Ciwla3in4Clb8gREDPONRSJB7h/dEyeSz8h/M6Oe8WLhDHymfI3
 gqaG0ZKquzEootz+97M3PjWo4CsGup4P0xbA2iLtebsZXeGpjKumNYSXvyJcDbRUHLP1J+jP
 egFnevhNPAnnUpRt9UuHrtuy5U47YS9qrJfyDNiAyyXPVmmD7VXIk6G09NKgatDy+ILogCxQ
 E+OpoBXNLjVasPoFFkdeFgsYuiZj6pGnzDT6bE4Ihy/6nMturWAVkpWMl+HjykEdOl5N4Ysw
 OEAvs8K6lzg1kB7bI7e1i0EpX6RKnEgUrk8ss1ICoHcjAd2mEpJZobRC3Or7ZzTOc9ANFImf
 m2diKbY3e8Ow0PDdz8+FyGI07YHw5sJvx9OwRkJIFHQwojJgfo+3Rtw9zUrT1QKkk8WjborY
 mU7ZVdoIaiu/itzgJQRVW6bHQwcVgaS/Vb8ygdUmWDUJ6Vyurch8IHg1SexEEElH6Z0ezFa+
 PSVyj+gX2qwOs722SQ2VAhurPmLoRmdMOHdsJjPIihHN8BSjfnZbmuGam8Bqh+hCsQ07KECj
 fc/5/5+MMUXKgZJy5DWyOCmOXA4RxWNJWgESvZklE/M8acwZxnqsQWzx4uNlg+h6hAEHYJUy
 yCjGy6XaymD6Q==
IronPort-HdrOrdr: A9a23:hA1Sc69TDFyTaVUVpyBuk+DnI+orL9Y04lQ7vn2ZhyYlC/Bw9v
 re5MjzsCWftN9/YgBEpTntAtjjfZqYz+8X3WBzB9aftWvdyQ+VxehZhOOI/9SjIU3DH4VmpM
 BdmsZFebvN5JtB4foSIjPULz/t+ra6GWmT69vj8w==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,225,1650924000"; 
   d="scan'208";a="17810163"
X-MGA-submission: =?us-ascii?q?MDEleQR34luR783miFJx31y4HYkN0yH6bmOa0n?=
 =?us-ascii?q?U9pHF8i4tB/YBEbLsC+t1rMf/Jn+fY6z954X+N8qeiLgDFUM6TojnBen?=
 =?us-ascii?q?vt9igU4IHQVdJN3c+co9wwWFzgjMzBKd3w/4FmkLkpyfqGqeDjHr/xYY?=
 =?us-ascii?q?J83kHVWHLsFAviPYNd5rXFFg=3D=3D?=
Received: from mail-ej1-f42.google.com ([209.85.218.42])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 03:41:08 +0200
Received: by mail-ej1-f42.google.com with SMTP id d2so4214823ejy.1;
        Sun, 26 Jun 2022 18:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xOZyz54bapplfevA6IoBBeOERMm6lF270gKiNU+5SS0=;
        b=OY08AUHrqEyhZjPXHAwu/Re4XSwQ7eUOOJRTBZERy68JFYUIuxDYh2JhzL5E1nUahd
         Dyb5j9ezXf4gtKt5Y5Hlx3uM0qv/nYytspUtm9XbBMzc5imUwpyNacMdYdgytv8bDI1R
         nqn1D6ihujCaB6Z4EzoS/NN9Urbnkp3R7nWF6cgUQFrn/YmdUuNj/XH4cUsFM/89DT3r
         MX5lLmITv1TnFRgJL2vsASVg4KFSwbbEPU9DFsziuHSboui/oVqBlxddRkdq8ptIRZOZ
         yI275ggimItq5HLOC4a7eQ76WyFC+JkZF4FHeZpyT5qB1dFgDLoCdGWReTQzppehDtIE
         B6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xOZyz54bapplfevA6IoBBeOERMm6lF270gKiNU+5SS0=;
        b=pV/9SZy08Cgfb6sPAFfV27qKXUszbMH8/IgioZuawkES9S3jn3pVttE0uUcZkNl7pR
         JPksQHRs/Lioixb5cuw6qmtDVneCVZ+COFJiJBq66nxOpeWyW2cjbDFbd6D4xEdodl+y
         G/27taEs43FrGrjAERhOV6ajA5bUc85OaTt2Ol07Au47kcKW8gC0RdSF0SHkOLJ8vxw5
         ycOuYqG7tKVg0N9H9IzwpVRsQO8XIL+D2VAwxmlAOonZDbgQoRy4wbUxkG9RjH28zpyd
         YXIaw0xpzNOvgpTV/7j8YzPUrovrQUD1rSoFxvcWCFQO7oafeJubNHScLhqQ1Db7ywx8
         8ixg==
X-Gm-Message-State: AJIora+gtsErvlF7GCnupf/0Gh7GgUL6kBUDLXsG0CCV9gtWePHRIAmg
	YE/w6riw2CPHqHUSPeFWudGYbkaYBIf4Js418rk=
X-Google-Smtp-Source: AGRyM1s7ySWKu6udqIOVdcXsWUV3jdlPVn3AuS2PaJH44x+HWk/ZbqP4+oYVj114c0ZZlNcMePIp98lzsU0Fa7/TE6o=
X-Received: by 2002:a17:906:38ca:b0:722:e836:1d85 with SMTP id
 r10-20020a17090638ca00b00722e8361d85mr10421852ejd.194.1656294064765; Sun, 26
 Jun 2022 18:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220613071243.12961-1-dzm91@hust.edu.cn> <Yqbu8TwmaXdBiIBs@debian.me>
 <alpine.DEB.2.22.394.2206131212160.2812@hadrien> <CAD-N9QUOk938-+1CtGfWNKUvWowknKScLuFXXkFAv59M=-F84g@mail.gmail.com>
 <877d554zvj.fsf@meer.lwn.net>
In-Reply-To: <877d554zvj.fsf@meer.lwn.net>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Mon, 27 Jun 2022 09:40:23 +0800
Message-ID: <CAD-N9QX8w1pmYw85Og_vhOE63GgL3ZF4+5uLc6kBjBiJr_F3_w@mail.gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Julia Lawall <julia.lawall@inria.fr>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
	linux-doc@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] dev-tools: fix one invalid url
Reply-To: Dongliang Mu <mudongliangabcd@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 461
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/CAD-N9QX8w1pmYw85Og_vhOE63GgL3ZF4%2B5uLc6kBjBiJr_F3_w%40mail.gmail.com>

On Sat, Jun 25, 2022 at 3:37 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Dongliang Mu <mudongliangabcd@gmail.com> writes:
>
> > On Mon, Jun 13, 2022 at 6:12 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> >>
> >>
> >>
> >> On Mon, 13 Jun 2022, Bagas Sanjaya wrote:
> >>
> >> > On Mon, Jun 13, 2022 at 03:12:42PM +0800, Dongliang Mu wrote:
> >> > > From: Dongliang Mu <mudongliangabcd@gmail.com>
> >> > >
> >> > > Fix the invalid url about Semantic Patch Language
> >> > >
> >> >
> >> > I think what this patch doing is to point SPL reference URL from old
> >> > Coccinelle documentation (doc root) to actual SPL doc entry on new
> >> > Coccinelle page, right? If so, "fix invalid URL" may not be right patch
> >> > description and title.
> >>
> >> Agreed, thanks for the suggestion.
> >
> > Okay. Let's modify the title to "modify SPL reference URL to actual
> > SPL doc entry".
>
> Normally, the way to effect such a modification is to submit a new
> version of the patch reflecting the change.

I know this rule. It seems I forget to send a v2 patch.

>
> I've applied the original patch and made the change, but it's better not
> to ask maintainers to do that.

This change is surely on my part. I am sorry to forget about this v2 patch.

>
> Thanks,
>
> jon
