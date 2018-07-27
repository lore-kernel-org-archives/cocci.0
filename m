From: timur@tabi.org (Timur Tabi)
Date: Fri, 27 Jul 2018 16:28:45 -0500
Subject: [Cocci] Search/replace inside string constants?
In-Reply-To: <7a83d1c1-f8f6-3027-f3f4-5c9247445bfe@tabi.org>
References: <CAOZdJXUV2CS=V8K3WMmWXZf5cE9Jrgfwv2e-R0+PJGrzj3tr1Q@mail.gmail.com>
 <alpine.DEB.2.20.1807270034400.2489@hadrien>
 <CAOZdJXWgmXbbTjOJL2osCLE_sy7kdb-_fnrPx7QnrSuZCnaQ2A@mail.gmail.com>
 <alpine.DEB.2.20.1807270051320.2489@hadrien>
 <CAOZdJXV4rb-Snt95ZcLJG1v-qV_O+RKjC=X0ACZghmDK=WXGnA@mail.gmail.com>
 <alpine.DEB.2.20.1807271845380.12787@hadrien>
 <69450411-cc54-ccad-2dfa-7dfbd439c0ba@nvidia.com>
 <alpine.DEB.2.20.1807271910330.12787@hadrien>
 <6ca5500f-039e-e586-9366-719f847f3352@nvidia.com>
 <alpine.DEB.2.20.1807272139060.3602@hadrien>
 <7a83d1c1-f8f6-3027-f3f4-5c9247445bfe@tabi.org>
Message-ID: <8f3a262f-01c6-650f-a26d-ee7d32dfb264@tabi.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 07/27/2018 03:25 PM, Timur Tabi wrote:
> 
> That was it, thanks!? It all works now.? You can add me to the list of 
> coccinelle fans. :-)

Looks like I found one particular failure:

-        DBG_PRINTF((DBG_MODULE_OS, DBG_LEVEL_INFO,
-            "NVRM: %s: Current security token doesn't match the one in 
the client database. \
-            Current EUID: %d, PID: %d; Client DB EUID: %d, PID: %d\n",
-            __FUNCTION__, pCurrentTokenUser->euid, pCurrentTokenUser->pid,
-            pClientTokenUser->euid, pClientTokenUser->pid));
+        DBG_PRINTF( DBG_MODULE_OS, DBG_LEVEL_INFO,
+                   "NVRM: %s: Current security token doesn't match the 
one in the client database. \
+                   ,
+                   __FUNCTION__, pCurrentTokenUser->euid,
+                   pCurrentTokenUser->pid,
+                   pClientTokenUser->euid, pClientTokenUser->pid);

It didn't rename DBG_PRINTF to NV_PRINTF, and it screwed up the string 
literal.  I'm guessing the \ in the middle of it is the problem.  I'll 
just fix it by hand,
