Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289A1C433F5
	for <cocci@archiver.kernel.org>; Wed,  9 Mar 2022 20:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=jzH4mBJT9hompZmJdGrrRDRPEC+3Z2xuDo2g3YT6QA8=;
  b=dSHofOpXzGjHjHE/UXs7jIvsPYJqYYL+a8DremawAdaWLEVlHU5Ddn5j
   rWcufrSVDI/Fh0K0uGUCiRPHYQ/AxQtMECP8gzy3n8DS5nn2tzn76+yBj
   Uw93LA8mnMWpNDR3xVDSP0rIymyyscjpRLwA79TGBy4KYMJLk4NdXONbn
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.90,168,1643670000"; 
   d="scan'208";a="25324718"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2022 21:23:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B8979E1D37; Wed,  9 Mar 2022 21:23:10 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B27D1E0164
	for <cocci@sympa.inria.fr>; Wed,  9 Mar 2022 21:23:04 +0100 (CET)
IronPort-SDR: OwUXorlG2/8NgJkf5W1ZRxaRdmnesydk6W6nFvVPlhcdPGSdvMgS91UV1Mz06fRcbdK5Ils2gm
 NZ15ANmyfMB6Eyo7H+q087zq07UY3lZISwyBmAPpT3mX+u91J4xd0RRLtt7oGUOhsJk0hOWRAa
 gBJBXRjl5rp+9fN9J6WF39zAIhxDiTU8qlyAw7IYryrYFx3Q/J172ndPlHV7viwc1F1x1F8IOF
 T8zgABUBrD7RMIEJtRvG+FU++b9wezAiFI+3lj/2K9a8iclMwbB+AJmMyskNuNCfa/JJ/zdjaW
 UEbnCddfQro/ZNA8RLQvDNQS
X-IPAS-Result: =?us-ascii?q?A0CAAwAUDClihk7ASNlaHgEBCxIMQIQCaRVXKwQLRIRUj?=
 =?us-ascii?q?nOBdzGSOYwiCwEDAQ01CQECBAEBghKCdQKEIgIdBwEENBMBAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIDBAETAQEBDAsJBwgKBw4FCwU2Bl4GZASBSwSBd?=
 =?us-ascii?q?As0DYI1KQGDZAECAgEjHQEBESYBDwsaAiYCAlcGDQgBAYMAAYJkAQMNJQuuR?=
 =?us-ascii?q?IExgQGCCAEBBoE/AYMIHywiUoFbAwaBECyOSCcQgVVEgTyDAz6HX4JlmCeCP?=
 =?us-ascii?q?aFnnkA0B4ISgTqBQAuJP5RMBhQug2EBklcOBpFlllWNE5lmgXiBfjMaJIM4T?=
 =?us-ascii?q?gECAQINAQICAwECAQIJAQECjh0ZhAyBC4khQDQ4AgYLAQEDCYVHAQGMJgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:jIxJLalyAGHZ7wgxRGomwz/o5gz1IERdPkR7XQ2eYbSJt1+Wr1Gzt
 xJLDW6POK7cYTf2KNp/Pd6/905S7MLUmoU2T1A4/ypgH1tH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvykTres1hlZHWeIcg944f5Ys7N/09YAbeSRWVvX4
 4up+5yHYzdJ5hYtWo4qw/LbwP9QlK+q0N8olgRWiSdj4TcyP1FMZH4uDfnZw0nQGuG4LcbmL
 wr394xVy0uCl/sb5nxJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwZG8P4whlkeydx
 /1g6rvsQgRzIpbWo9kQDygBIn9nOfd/reqvzXiX6aR/zmXDdGbwhepjBgc6MOX0+M4tWD4Iq
 qZecWFXKE/T7w616OrTpu1Eo805L9Tweq4btGthyz7xEvssB5zOK0nPzY8AjWZp2Zwm8fD2a
 84eUWooQRL6RBhAZHEmCYtijt+OmSyqG9FfgAvI+fRuuja7IBZK+LPqO9HUUsebQN1c2Eeev
 GPPuWrjajkePcOWzT6t4HOpjPXG2yL9QoMbUrOinsOGm3WWwXEPTgIbXx23rJFVl3JSRfpyd
 GtI8Sl0sZMoz3GmEuikbkOhpCS960t0t8VrL8U27wSEy6zx6gmfB3QZQjMpVOHKpPPaVhR3j
 wXYzoiB6ShH4eHEECr1GqK892vqURX5O1PucgcoYGM4DzTLpYYuklTQQ9wlHKPdYjzJ9dPYk
 23iQMsW3e17YSs3O0OToAGvb9WE+MKhc+LNzl+LNl9JFysgDGJfW6Sm6ELA8dFLJ5uDQ1+Ks
 RAswpbCsr9QUcvVzHfWGY3h+Y1FAd7aYFUwZnY/R/EcG8iFoCHLkX14vW0vfxg3Wir6UWWyM
 BCN0e+u2HOjFCL3MfEuOtzZ5zUClOa5XdXjSv3OaNdSKpF+HDJrDwk+DXN8K1vFyRB2+YlmY
 cnzWZ/1UR4yVPo7pBLrGL91+eJ6nkgWmDKILbimnkTP+eTEORa9F+xeWHPQNb9R0U9xiF6Jm
 zqpH5DXk0k3vSyXSnW/zLP/2nhRdCllX8+q85ILHgNBSyI/cFwc5zbq6etJU+RYc259zI8kJ
 1mxBR1VzkTRn3rCJVnYY3xvcu29Qpt16342ZHR+MVGt0nklQICu8KZGK8ppJ+Z6rrQ7wK4mV
 eQBduWBHu9LFGbN9QMdWp+h/oZsQxKm2FCVNC2/bTljJJNtHlSb+tLtcgb12jMJCy676Zk3r
 7G6iFHETJBFSwk7VJTab/emzlWQu3kBmbsuDhWSfYQJIB3hqdE4JTbwg/k7J9A3BS/CnjbKh
 RyLBRo4pPXWp9Fn+tf+hZeC89WjHdx4ExcIBGLc97u3aXLX82f/k49NVOGEIWLUWG/uofzwY
 OJI07fjPfdBkFsT69hwFLNizKQf4drzpuYGn1o+QyiRNwymWuF6P32L/chTrakTlLVXjguBX
 B7d8NdtP7jUatjuF0QcJVZ+Y+nfh+sYnCLesaY8LEngvXYl+b2aTQNNMhPKhCEEdOl5N4Ysw
 OEAvs8K6lXj20RwbYvc1nhZpzaWM3gNc6Q7rZVEUoXlvQoczA0Qa5LrDCKrsoqEbM9BMxVxL
 zKZ7EYYa2+wGqYfn7sP+XnxMS51gJMTpFZVwVVEK1nhdh8pQBMo9EU5zNj1Zl09ItZ7PyZbJ
 WVhcUF4TUlL1yk9n9BNBghABCkYbCB0OSXNJ58hi2DTCUWlPoAIwKvRJs7VlH0kH6lgkvS3M
 V1WJKsJkdonQS0p4hYPZA==
IronPort-HdrOrdr: A9a23:R91wz6uiRlMxegCCGkq0d+PF7skDUtV00zEX/kB9WHVpmwKj5q
 STdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQouVvvJrIuQ/EpU0dNj2ChpsQlTuQM2ygYzBLrIIqP/AEKK
 Y=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,168,1643670000"; 
   d="scan'208";a="8099174"
X-MGA-submission: =?us-ascii?q?MDE6ukQESGEUKp7FGnFdPAYnRPgrTd0Z0w5cAQ?=
 =?us-ascii?q?+XHcw36KayVFM6bPuWizjs2sH6N0CwYxlwlg347Xo3xrRaID4UIaLWvF?=
 =?us-ascii?q?0Rs6Q3eO3brxuI7sumWbWEYBiUAw/WJWQYwvyAq+TWpKpoQJPEc8KRiL?=
 =?us-ascii?q?LzpOa7ztZ8lliVW6GSEtX6jw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 21:23:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1646857382;
	bh=dsG7ig1g3DOqluCEQroiAFALzreQ9RUBv6KevoVB+MA=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=c6VxsXDZXSvqR6+m81owxDErrqIOjL1MH1sfT6NjYxW9JKT+zKowfWFGFabnBu8VN
	 mjM8O+h8XFan9vgxCen7hAsPi21KQ6BXyiupilx15S+qPXuZbCyzn66ELaRvlMtzlk
	 GyBiFD0tY7Kn+vf5yJVGkPLj7lIrvQPsKib+JLFc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.114.231]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzCED-1oNk611OhH-00w4Jq; Wed, 09
 Mar 2022 21:23:02 +0100
Message-ID: <f564b217-03a3-0b27-1a23-2dbf959c80a2@web.de>
Date: Wed, 9 Mar 2022 21:23:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
References: <df8a810-dcb1-4bf2-178d-178943e6e458@ewheeler.net>
 <caa0adde-7dd-e571-fa2-ee2a650b328@ewheeler.net>
 <alpine.DEB.2.22.394.2203070900200.3091@hadrien>
 <2018915-898b-778-b5e-c8683697ed40@ewheeler.net>
 <alpine.DEB.2.22.394.2203072145310.3091@hadrien>
Cc: Eric Wheeler <cocci@lists.ewheeler.net>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2203072145310.3091@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:g/TzyxFygXbKL0agDbEj+5+f8w/kaDOb0blSI45SQcvtjiUBkyk
 OQbGZweKahonb98LmxefJPcjUZqdQamEYF0hJl2vLqlKe1V+uuLgMTUcQD1Cw0wAZXWFxg/
 XG5YY+g08JcbdI/cdZ8hXLUHz608ShufAe9ENyw0vFTBPvsqXNQcbsqHApUmwt31alq+bO7
 ndxkrvE+xPex2qCCsPLpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:azwt1Agwrg0=:sa0dNJAxBtMmxRfeQ/VGP7
 Stq+924i0kpyBBGHTx9SqrdvDZOrUGysGF99T3uNk5vFrUK7JxUlC9+QEu4ioZ6th7PrQNIIe
 jSozi1PNniLeyn9EaZg27OehsifsD+XPvIicCWrQHukYdBXAV8nQls+SLlmbHSyRTixP3AmfH
 f8Ug1OhKj83tndvTE5op88J1JIf7AFybk6IsMtCeffzwIKFLxUS5dZmNdrkoXxo7kj2m9OpLf
 GYLHlBdi6rAno4nQetITmZS/IVSpGASg6L3cfO/o3JEprTGNaeT4bVzpGocnTB1FHVe5/C5pq
 jxxE1FByUTESEmJr7JTFB5QMrDfs/arP4D1eUwFqD1qfrd4jGVdzoB9IBDMb/4Db8UJTHIJU+
 YJFWnMfk4aIjHj0NtjWz5DpOvCCsOLFXPmUF/q3aal74H7sH55eACw/2VAxdfyEYwXa/bPL96
 ms0WffSRRZzulJh7l4ncrnnxZtjXb2M0sddJkrAY7HD7gDL+LeJcQIojiNz/CYeNj0QAH+W89
 IuX9UaQalUHgb6mJ8bUogDl4z8uRB9mGEuRujU8Zv0x+UE5i5VRuHIwhHuN87kJYOoYfPM/84
 WiWZaYFHI8Tw40HdC+oUIp/O44wvSk35pBO3UBtZxohVjImRbwfAx9wwrUidKALL14jtNu7eS
 IF5CQgLg5c0+56B8Zf+SCjij2IorlcEaaYRzPFD4jjXntGiNc5iiOytoWnpUo93Q+N3iATC5e
 f7o/kd0KNei+wPy/RS3u9hkMLW1JhP2LVFpm7AJk9p/+VuEdtOOboN9ZQRfZTpyJdqpFZdk2r
 oF/tavvJeBpYFDpm3jWlX9xu3I96Uxysg76KYZs++b0dadrXOkjwRP57Xfa4bR6cyxSrvviZH
 Zp2KuTfv5hKVqimHyTbx4q1721c/nvNFkjFwsOxUVDQeTL+P112TSY64I8GGYqGKzu6n5feKn
 UeKXHfRlojJ/dAVWcwyrn9JUslefqYtVz2myGi1GlhmN7zOW+pP+3MUmMfG243f1uzbpoU29s
 +p1LMO7r0JxMMw+Q6oQe3PoElGEnP1GxPPJe7IRstALCKL0KaHpthsYOgFcHWPppQVb/5G3i/
 AeNUDe08o65cQ8=
Subject: Re: [cocci] [PATCH v3] Fix support for "complex double" in
 parameter lists
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 193
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/f564b217-03a3-0b27-1a23-2dbf959c80a2%40web.de>

>>     Fix support for complex double in parameter lists
> Applied, thanks.


How does this feedback fit to a related display from your software development repository?

https://gitlab.inria.fr/coccinelle/coccinelle/-/merge_requests/173


Regards,
Markus

