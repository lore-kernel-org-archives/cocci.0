From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 27 Jul 2018 21:40:30 +0200 (CEST)
Subject: [Cocci] Search/replace inside string constants?
In-Reply-To: <6ca5500f-039e-e586-9366-719f847f3352@nvidia.com>
References: <CAOZdJXUV2CS=V8K3WMmWXZf5cE9Jrgfwv2e-R0+PJGrzj3tr1Q@mail.gmail.com>
 <alpine.DEB.2.20.1807270034400.2489@hadrien>
 <CAOZdJXWgmXbbTjOJL2osCLE_sy7kdb-_fnrPx7QnrSuZCnaQ2A@mail.gmail.com>
 <alpine.DEB.2.20.1807270051320.2489@hadrien>
 <CAOZdJXV4rb-Snt95ZcLJG1v-qV_O+RKjC=X0ACZghmDK=WXGnA@mail.gmail.com>
 <alpine.DEB.2.20.1807271845380.12787@hadrien>
 <69450411-cc54-ccad-2dfa-7dfbd439c0ba@nvidia.com>
 <alpine.DEB.2.20.1807271910330.12787@hadrien>
 <6ca5500f-039e-e586-9366-719f847f3352@nvidia.com>
Message-ID: <alpine.DEB.2.20.1807272139060.3602@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

It seems that the last rule would be better as:

@@
expression list[r.n] r.es;
constant char[] r.c;
identifier s.c2;
@@

NV_PRINTF(es,
- c
+ c2
  ,...)

It seems that when you remove and add back a comma, it thinks you really
want a comma to be there, and there is none if the string is the last
argument.

julia
