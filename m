Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7888BF3382C
	for <cocci@archiver.kernel.org>; Tue, 17 Mar 2026 09:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=+PXqlwhoyPlm589VK6bnqcQQvYtPbraPr9ytVRkoTe0=;
  b=suSGSyhaPZbQ1VbidCh8EpaEIfsLQ1tVtrtbhofMvnw9dCR604q5vwqH
   dUf8JQdh6T0gvZTXSrsvZ96rg3MRyyfbHfXyI2qDHT8aWuq4+gNPCzrFH
   8CECblH+OxOS+GT8vSdt377pcKwkVYElCmTO39Q0grE8aY6vEuxFsT3pm
   k=;
X-CSE-ConnectionGUID: e9ChgwPlQqOUIV4/7EIebg==
X-CSE-MsgGUID: 4zHNV4L2TCiSAYdDUHNW1A==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,124,1770591600"; 
   d="asc'?scan'208";a="268119280"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Mar 2026 10:40:39 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id CD15D822FC; Tue, 17 Mar 2026 10:40:38 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 9D4EB8200F
	for <cocci@sympa.inria.fr>; Mon, 16 Mar 2026 11:39:40 +0100 (CET)
X-CSE-ConnectionGUID: PAJ/AOWvQs+yN22mt+Oapw==
X-CSE-MsgGUID: dMlzNyl5TOqvJDWF2fyOFg==
IronPort-SDR: 69b7dded_1z02/Mn5O+Ep/aX24dy6l3WvTI9w7YB7zruMA+zwb3nGZ+I
 oFUmeiZCwoVHkr6BsI1UMLpssjEoIBnqe5h1XfQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GyAgDP3LdphR/86qxaglkCgj+BB18zBAtJhFiDT4Ush?=
 =?us-ascii?q?lhbAQEGgUGFeoV6hneLL4F9AggHAQMBCAU3GgQBAQMBA4UAAo0jAh4HAQQyB?=
 =?us-ascii?q?w4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBAQFASYZPD?=
 =?us-ascii?q?UkBEAGCBwEzcYElAQEBAQEBAQEBAQEBAR0CDX4CAQMjBBkBATcBDwtCAgIQR?=
 =?us-ascii?q?gaDFQGCIgdKA7ccfzOBAYIMAQEGgQjbIoFeCQMGFYE4gViGcAwBgV2EF4QAe?=
 =?us-ascii?q?icbfYEQhD8+iB6CaYImgQ6IUoJkhztSgRQDWSwBSwo1DDMrRUMDgSlLBTdlE?=
 =?us-ascii?q?j8hHQ8cHzkCOAcFEiERGU54ggEPhmV5AyMLXhoOIgI5XEo+XQWCLAInA3g9N?=
 =?us-ascii?q?xQbBIwiECENggo8gw41KyDJDoQmojiXP5EGghMumFipQYFvATKBXDMaCCgIg?=
 =?us-ascii?q?yJPAxkPjjqEYoQYxBRCNT0CBwIHDQMLjRuFAYFLAQE?=
IronPort-PHdr: A9a23:qpT27REKzBfMovgmf1I1+51Gf0FFhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k20BmRBc6BuqId1aL/iOPJZy8p2d65qncMcZhBBVcuqP49uEgNJvDAImDAaMDQUiohA
 c5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFRrwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/I
 Ru5oAnLqsUanYRuJrg1xxbKv3dFevldyH91K16Ugxvz6cC88YJ5/S9Nofwh7clAUav7f6Q8U
 7NVCSktPn426sP2qxTNVBOD6HQEXGoZixZFHQfL4gziUpj+riX1uOx92DKHPcLtVrA7RS6i7
 6ZwRxD2jioMKiM0/3vWisx0i6JbvQ6hqhliyIPafI2ZKPxzdb7GcNgEWWROQNpeVy1ZAoO9c
 YQPCfYBPf1FpIX5vlcCsAeyCRWpCO7p1zRGhGL53bci3uovEQ/IwhItEc8NvnTao9r6KLodX
 uKuwanH0TnOdelb1Svh5IXKdB0qvPGCXah3ccrU0UQiCwfFgUuSqYP/OTOay/4Ns2+G5Od+U
 uKvj2knqwRrrTi128whjZPGhoYay13f9iV23pw1JdumR05/e9KkF4FQty6DOoZwX8gtTH1mt
 jwgxb0apZ60YjIKyJI/yhPbZPGLb4aG7wz/WOueIzp1i25pdK6xiRqv7EWtyeLyW8a33VhEr
 iRIjtjBu2wP2hHR9MSKV+Vx80e/1TuPyQ3e7PxPL04zlareMZEhw7gwm4IJvkTHACD2ml/5j
 KmLeUU+/eik8vjoYrLipp+bMo97kBv+Pr4wlcykB+kzLwsAX3CD9Oih1rDv41f1TKtEg/A5i
 KXVrpDXKdoBqqO3HgNZypsv5wqjAzu80tkVnWMLIVZbdB6dj4XkOFfDK+3iA/ilmVSjijJry
 ujGPrL/BpXNKWDOkKz/crln8UJc0w0zzc1F551IFL4NOvHzVVHrtNzeEBA5Nxa4w+H9CNVyz
 o8eWGSPDbGFMK7KrFOF5PwjL/OSaIIbtzvxMeYp6v7wgXMjl1IRYLGl3Z4NZ3C5GvRmLV+ZY
 X3pgtoZC2gKugU/QffpiFKcSz5TYWi9X6Ym6jE8EoKmAp/PRpqxj7yZwCe7AppWa3hCCl+WH
 3bnbYGEW/MXZSOTI89hlycLVaK7RIM71BGushX6y7t9IebO9C0Yr4rv1MJp6O3LiREy6Tt0A
 tyB3GGKU257gmIISiQt3KF/pEx90k2M3bJ5g/xeD9xT5ulGXh00NZ7G1+B6Dcv9VRrbftiVU
 FamXsmmATYpQ94v29MObFhyG9KhgB7ZxyelDaIbm6SRBJMq7KLS3GL/Kt5my3nYzqYtlUImQ
 sxSNW28mqFw6RLfB43XnEWDkaala6Ac0DTK9GeZwmqCpFxXUA1xUaXARX0RfkTYotrn6E3eU
 7KgD6wrPRZEycGYMKtFdsXkg01fSvn7N9rSe3mxm3++BRuQ3L2BcJfkdXgF0CXGEEgEnRgc/
 XaYOgg6ASesu3rQAiV2G1zgMAvQ9rxboWm4U1R84gWEdUxn2PLh3xcPhuGHDd4X0KgFvigJt
 Dh+WlqwiYH4Ed2F8iNlcadVZ98n5x9s0mbesgVndsipK7BKhVMEdQlz+UT02EMkWc17jcE2o
 SZyn0JJIqWC3QYELmvAtXiRErjeK22ouQuqd7aTwFbVltCf5qYI7v087VTlpgCgUEQ4oD18y
 9cA9Xya693RCRYKF4rrWxM+8whSpLzAZCQ5oYTO2i4kKrG65wfLwMlhH+450lCldtZbPrmDE
 Vr7F90yBMW0LuEu3V+zYUFMJ/hcoYgzOc7ubP6awOirMeJnySqhlnhC6Zth31ik7Cd1DPXPw
 owOzreb0xGBWjO6i02u2izusaZDYzxaXm+2yCy+QZVUerU3Z4EAT2GnP8ywwNx6wZ/rQX9Rs
 lC5VRsA34eydByeYkaYv0UY3FkLoXGhhSqzziBl2zAvoK2F2SXSwuPkPBMZM29PTWNmgB/iO
 4+xx9wdWUGpaUAumn7HrQ7zw7hzp6llKWTXB0BScGm+Lm1vVLexqqvXe9RGu9sjtSRaVvj5Y
 EjPE+Gn5UFBj2W5QjEYn2loElPi8o/0lBF7lm+HeXN6rX6DPNp12Q+a/tvXA/hYwjsBQiB8z
 zjRHFm1edezrrD239/OtP6zU2W5W9hday7umMmJsDuT5mBwBxC72feplZe0WRh/yiL929RwA
 G/BqAbUYYTx0am+d+V9cQM7YT20o9o/EYZ4nIwqgZgW0nVPnZSZ800MlmLrOMla06bzBJYUb
 QYC2MWdoA3s2Uk5a2mM25q8THKWhM1oe9i9ZGoSnCM79cFDTqmOvvRImi58o1zwqgy0A7A1l
 zMN4fgj8ngXh6cOogVlwiiGA78UFFVVJmS1yE7OtYvi6v8KPiD0KPC5zwJmkMqkDa2erw0UQ
 3v/dpo4XEoSpo1+PF/KzHzv+9ThcdjUY8gUs07cmBPBgu5JbZMpw6NV32w9Yj675yB/jbVi3
 nkMldmgsYOKKntg5ve8Cx9cbHjuYt8LvyvqhuBYl9qX2IamGtNgHC8KVd3mV6HNcnpauPL5O
 gKJCDB5pG2cHO+VFAuPwERrtXTCF9asLX7ddzEJiM5vQhWQPhkViQQEdDY3hJg0Ekat3sOrI
 yIbrngBo1X/rBVL0OdhMRLyB3zeqAmfYTAxUJGDLRBS41IK9wLPPMeZ9O42AzBA88jrslmWM
 mLCLVctbylBSgmeClvkJLXr+dTQ773SGL+lN/WXKbSW9b4DDbHSmNT2idogpmrUfsSXYis7U
 Kd9gxIeGyw/QZmF/ldHAy0Py3CUMJTd/kzgvHcq9IbkqbzqQF69vNTVTeEJbZM2oUjw2vfLN
 vbM1n8mc3ABjs5KmyOOkehDuTxawzdncz3neVgZnQjKSq+Y2qpeDhpBLjh2KNMN9aU3mA9EJ
 c/cjNrxkL9+lP88TVlfBxTnnYmyaMoGLnvYVhuPDVuXNLmAOTzAwt3mKaK6R7pKiexIthq28
 T+FGk7nNz6HmnHnTReqee1LiSiaOlRZtuTfOl51DnP/Sdv9dhChGMR6hHstxqAujX6MNmMGN
 zV4NURXofzY7C9VhOl+B30U7ndhKrrh+W7R5O3ZJ5AK9PpzV30rzaQAuyh8keYPqnodF5kX0
 GPIo9Vjok+riLyKwztjCl9VrypTwZiMtgNkMLnY8Z9JXTDF+ggM5COeEUdvxZMtB9vxtqRX0
 tWKmrj0LWII+tbE1cgRHc7ZLISAKnVrYn+LUHbESRAISzKmLzSVn0tGjPSb7WGYtLAhp5Gqg
 50TULRWEl84DPUXDgJiBtNIc/IVFns01LWcisAP/3+3qhLcEd5bsp7wXfWXGfzzKTydgNGsi
 DMLzKn+IIBVMZf0iRUKgrxSn4nQHUfUG9dXrX85BufViF5A+T5lSXAp0E+jaQ635nIXU/muk
 Uxu4jY=
IronPort-Data: A9a23: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
 RvKeodG34xaNrH/d0fkVxLFTJKY0c62I/U=
IronPort-HdrOrdr: A9a23:f9cWqKoXl8be8Wr4/9SXZ5IaV5okeYIsimQD101hICG9vPb4qy
 mLpoV96faUskd0ZJhEo7290ca7LU80maQb3WBVB8bFYOCEghrMEGgB1/qA/9SIIUSXnYRgPO
 VbAspD4bbLbWSS4/yV3DWF
X-Talos-CUID: =?us-ascii?q?9a23=3AKUQ+pGvfeK3fAWCb3g/izunr6IsdW1+a5VDvPXa?=
 =?us-ascii?q?jSndPEueQVRy38bt7xp8=3D?=
X-Talos-MUID: 9a23:3UIPEAb4haaOY+BTuxrolhdzMJpUxL2wKmwyv88Iqu6qOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,124,1770591600"; 
   d="asc'?scan'208";a="267937415"
X-MGA-submission: =?us-ascii?q?MDEgnOKBMtjeOQURXaUPI+yukjfS21x5jhrN0o?=
 =?us-ascii?q?lS+28hZkrYJsz3XL6E8Qgrk35S0uRYGFThNOmPnHp0Aqp6bKti16VDW4?=
 =?us-ascii?q?PVVRyOEUErrFwD1EhB/mu9HGiUCtqccvESBBbibsKqVaVNmKosQYBaRL?=
 =?us-ascii?q?27UalGyaTSU/E2uzEgDqQLcw=3D=3D?=
Received: from sea.source.kernel.org ([172.234.252.31])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:39:39 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B830C417CC;
	Mon, 16 Mar 2026 10:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1111CC19421;
	Mon, 16 Mar 2026 10:39:35 +0000 (UTC)
Date: Mon, 16 Mar 2026 11:39:33 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr, 
	Nicolas Palix <nicolas.palix@imag.fr>, Kees Cook <kees@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Message-ID: <abfdDqYbRWZ6UNjB@devuan>
References: <cover.1772752564.git.alx@kernel.org>
 <9fd8d3d1e7ef3efb6e6dae0972dd515ff02e42bd.1773058287.git.alx@kernel.org>
 <806bcb6d-3ebb-4454-973c-f9d6530a17c2@web.de>
 <aa7XD-rk_KWQvTQX@devuan>
 <abblv3nCut5aRk7q@devuan>
 <0c5eded9-f56a-434c-a04f-b229945ae4c5@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="54decdtviyiimcq3"
Content-Disposition: inline
In-Reply-To: <0c5eded9-f56a-434c-a04f-b229945ae4c5@web.de>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [v2] scripts/coccinelle: Add script for using
 ARRAY_END()
Reply-To: Alejandro Colomar <alx@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3440
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/bz7vLswwRooIeQFpTqpsMw>


--54decdtviyiimcq3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr, 
	Nicolas Palix <nicolas.palix@imag.fr>, Kees Cook <kees@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Subject: Re: [v2] scripts/coccinelle: Add script for using ARRAY_END()
Message-ID: <abfdDqYbRWZ6UNjB@devuan>
References: <cover.1772752564.git.alx@kernel.org>
 <9fd8d3d1e7ef3efb6e6dae0972dd515ff02e42bd.1773058287.git.alx@kernel.org>
 <806bcb6d-3ebb-4454-973c-f9d6530a17c2@web.de>
 <aa7XD-rk_KWQvTQX@devuan>
 <abblv3nCut5aRk7q@devuan>
 <0c5eded9-f56a-434c-a04f-b229945ae4c5@web.de>
MIME-Version: 1.0
In-Reply-To: <0c5eded9-f56a-434c-a04f-b229945ae4c5@web.de>

Hi Markus,

On 2026-03-16T08:18:17+0100, Markus Elfring wrote:
[...]
> =E2=80=A6
> > 	+++ b/arch/powerpc/kernel/rtas.c
> > 	@@ -555,10 +555,8 @@ static struct rtas_function rtas_function_table[]=
 __ro_after_init =3D {
> > 		},
> > 	 };
> > 	=20
> > 	-#define for_each_rtas_function(funcp)                                =
       \
> > 	-       for (funcp =3D &rtas_function_table[0];                       =
        \
> > 	-            funcp < &rtas_function_table[ARRAY_SIZE(rtas_function_tab=
le)]; \
> > 	-            ++funcp)
> > 	+#define for_each_rtas_function(f)                                    =
 \
> > 	+       for (f =3D rtas_function_table; f < ARRAY_END(rtas_function_ta=
ble); ++f)
>=20
> Are there development challenges to reconsider for macro definitions?

I've seen cases within macros that were correctly reported, so it's not
an issue with macros.

> =E2=80=A6
> > 	+++ b/drivers/net/wireless/intel/iwlwifi/mei/net.c
> > 	@@ -43,7 +43,7 @@ static bool iwl_mei_rx_filter_eth(const struct ethhd=
r *ethhdr,
> > 			return false;
> > 	=20
> > 		for (filt =3D &filters->eth_filters[0];
> > 	-            filt < &filters->eth_filters[0] + ARRAY_SIZE(filters->eth=
_filters);
> > 	+            filt < ARRAY_END(filters->eth_filters);
> > 		     filt++) {
> > 			/* Assume there are no enabled filter after a disabled one */
> > 			if (!(filt->flags & SAP_ETH_FILTER_ENABLED))
>=20
> Will any loops become better supported?

I've seen cases within loops that worked correctly, so it's not an issue
with loops.

After debugging like Julia suggested, it was indeed what Julia guessed:
some files can't be parsed correctly, at places unrelated to this.
There's nothing we can do to improve the patch.


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--54decdtviyiimcq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmm33d4ACgkQ64mZXMKQ
wqm3Ig//VTIw0MfrevcDnVojqpoLgYkgVu5sSa9BFr8xaGHqsLg5A8aj6JkgUOL4
keVhKsFy3nNNTmCHeEYSj2zcjkeFFbTfqv9ZmT5BoPRhSMsVji2IkhG7IR9mkK6a
XV5Dx+ZZEAWuPu9ydJc5tDsHVViqP9FXsR4WQTYoYiQ57M55GugWByEuS11M1U6z
q8OU92MZAoJbRClRNJp+095JAlIb455mJcK1Mhn50bgaIAAnkMJAg/8XsQa3vpN2
QokH0+QC75lLdNz7tA8ho/8gm6Y6020SEdFCuFjnD1M+DxY5cI2nOtsVnAph5qXj
Pm8mgsDsmK4UwnEDGX5VJNIzoUCIZfE6Bmk+2Lgm5kOZakDT8fDMOe9jYysIrvDx
i/V8T3WLU35C3D3nW6UHvybE7ODe0xkwX+8eHqCSTXJwrxDlEhq73dyl2fHURcKW
UkANszES1VStZV5eieT5gc5bWZKYuFCGyWj8v5a2NKgOvGzjVLQ4aYbhQDWv3E/h
NZM1lz/tgfHnrUBH2FmuEFBoNZa441uyWot1Cn4n13chtW8YdOGxVvHQ854QlPRS
nZgSPSU3EpzgQ3fO3RZ0pd4NShLkuEc5COAtdi75HjVygQVls8nQ8x+1FoW6HZZJ
89p+M0FaUopvATfko7CeWzyrTSO0ytgiSgI+A0mxiibnfWt9TZE=
=u7B5
-----END PGP SIGNATURE-----

--54decdtviyiimcq3--
