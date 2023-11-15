defmodule NotifyWeb.MainDashLive do
  # In Phoenix v1.6+ apps, the line is typically: use MyAppWeb, :live_view
  use Phoenix.LiveView

  def render(assigns) do
    ~H"""
    <div class="bg-white">
      <div class="relative isolate px-6 pt-14 lg:px-8">

        <div class="mx-auto py-32 sm:py-48 lg:py-12">
            <header class="bg-white shadow">
              <div class="mx-auto max-w-7xl px-4 py-6 sm:px-6 lg:px-8">
                <h1 class="text-3xl font-bold tracking-tight text-gray-900">Dashboard</h1>
              </div>
            </header>
            <main>
              <div class="mx-auto max-w-7xl py-6 sm:px-6 lg:px-8">
              <div class="bg-white py-24 sm:py-32">
              <div class="mx-auto grid max-w-7xl gap-x-8 gap-y-20 px-6 lg:px-8 xl:grid-cols-3">
                <ul role="list" class="grid gap-x-8 gap-y-12 sm:grid-cols-2 sm:gap-y-16 xl:col-span-2">
                <%= if @current_user.role.name == "Admin" do %>

                    <li>
                      <div class="flex items-center gap-x-6">
                        <img class="h-16 w-16 rounded-full" src="https://www.svgrepo.com/show/81263/users-group-symbol-for-add.svg" alt="">
                        <.link href={"/users"}>
                          <h3 class="text-base font-semibold leading-7 tracking-tight text-indigo-600">Users</h3>
                        </.link>
                      </div>
                    </li>
                  <% else %>
                    <!--  suitable feedback -->
                  <% end %>

                  <li>
                    <div class="flex items-center gap-x-6">
                      <img class="h-16 w-16 rounded-full" src="https://static.thenounproject.com/png/4779769-200.png" alt="">
                      <.link href={"/contacts"}>
                        <h3 class="text-base font-semibold leading-7 tracking-tight text-indigo-600">Contacts</h3>
                        </.link>
                    </div>
                  </li>
                  <li>
                    <div class="flex items-center gap-x-6">
                      <img class="h-16 w-16 rounded-full" src="https://www.svgrepo.com/download/40707/group.svg" alt="">
                      <.link href={"/groups"}>
                        <h3 class="text-base font-semibold leading-7 tracking-tight text-indigo-600">Groups</h3>
                      </.link>
                    </div>
                  </li>
                  <li>
                  <div class="flex items-center gap-x-6">
                    <img class="h-16 w-16 rounded-full" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAilBMVEX///8AAADu7u68vLzq6uq4uLizs7P09PTl5eXIyMjExMTY2NjT09OwsLDg4OClpaXGxsaPj49WVlaampr5+fmkpKQ1NTVvb28nJyeJiYlZWVny8vJhYWHW1tZ5eXmOjo49PT0vLy9EREQbGxt0dHQSEhJPT08iIiJnZ2cNDQ2BgYFISEgyMjIYGBgOPFD0AAAIIklEQVR4nO2d6VbqPBSGaUEGmWQSUTyAIwe+c/+390mTlPRtkjZlh7Jc+/kltMQ8ZtoZio0GwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzC10ImLaSV0FSOdvuL1h0GGHvBw4j5LE7nrdUj9htvo9ljSOc7f6pax0Kcy/K9uEysxjeCkbg87axrDv3V7OJhTCHbrtnBB0hL7hBl6XM7uBoP+z+DRG07WBJXj4ZYMn2Z9rFP9yeeFid6Q4Z+ROfXmU/2G8+nlfqsXe/rjC9KdUAj+MLvQb+/w+yGuPN72iAQbjcFFggPdpjeerD6Wh81YjyurxUxbovE+ofNV2W967l4Gh0yjOw7TS1Ua4x9CvxNVA5tzPsbv+atDea3ln/AdsWCj0askeFAfvzOPC1N52bepf3fJBX9qaoXWsleftdbyo7zDb/Tf2zJ5IStfwa384Oj81vNq2B4uJst0wrkSt3gV4jiQYKNx72koO7s0ZpjqA/Ro+Jy8KUKB2CNZS/BAQvzoIyj7ERW6P2KYLJq2bKqlB8UpyXzCzqG8oGpiso+Z5dLaiAt+CVOFMXbuShvKIluKV4b4Q4aDreRFyeANkiEpzxH88bslh2c5EMh4KA1s4n5PtaNMpptl0nyD+O9AMiqOcmsFy1KGslcRLVcN7YOkDxWlq9rnffKqzHi7yuajc5Sfvdgweofea1jGUColP3/JD870S6rUmmUNm9lcDNK/zuWG5zJQ7/0rzI7sIkV5ywhEtrVv8UoFgqKWFo5EOwi0k78WnWH0Ae8+F2VIVtLkZ1nNVfS5FC/VvFPU2aJ6Yc4AoWH0BJHgoiBHYnLU023VgLDQ5KOSowVUIhVEQMWtRrrWBv3WqzNHO3HTRHNIlUS1VCW6FRed+waf0BGkQwutIc7InMsbsmLuTz/LcSMN3kSDUh2NGIw6LkF7Z05sGD1CY3dMGmXokYydspNvy0vv4qWMaOSA72qGC8jQ9/kStWGuZduXN2SYkEyK5FRAtVxZpHJCJSdCjoB3kP2dbf0avSEOui9HS7akVfKzbMCq8Uy0S6rK2kfDLwjM/mSuBjCM3mDXzjJp1PtLaagsmnqyMovWSBAC7Rg6pBCGueDXPFTLWvqu/dyQYYLoF5u6vHX+W/S7whjiPCjeGbK2EdeS7latOcRJlZYd46mX+pKDgK0543phvr4EMoyOzraR8CyuiA5TS+yc51Y6xo3yH084NDKYFopCGbr7t4QncUG0vUU+VQ3bxogh0L6iIdbUVi4kEcOcXENzraxYwr9dK3ubuakGNFTVMAXjymEm/7pi/6BV8r5luFlmU59bIn2SGbBtPRpjRVjeeJRvywDkINc0XpKDKzMRxnfHtuEUZ2u25dSghrlly9Yuc/VVZi59Yzddv51z+rjN3q7zzxZoX9sQq1J2eUPN6/03rrAB7O23hjaM3mHSmImfVU3reu4PQic2+nbcG9wwitqQHX0DJtUf+uxKwEDkXr28gmGupq61a+fhfTA5Kvfdetazb4G4A+1aDKMnGLj0biFTiTvxKO7MhYFtlIepy7xobfYqhlP8QF+rk0NTiid2xrRyC0v5YOn6htjxNbLLG0dLOGMKUXAJoYTiFQwNgpD/Z9OJiY5hAcS8Me9e7Q9vaDscmBkEP1cP+n5Dq7cwrWG1LUk5FYMbmkvwBE51Po/r5X49/XoznFc48c++Me9StP1ZvHDszjqPd3rtiTs35h2KgQ2xBGGsfigvCBPIAewW2/c0whpiCU4x3nope/4dhMa5CaVVMahhXvCnVP0iEgGGMXuDtE0xpKFJMIr+Qs5K7OzCemFXdkWQkGVBNaChWTDKTxqL4i4YLc8j/GsZxXCGKKgtMmC3+OHy28LGvF6tQdE4zwxmiBaZEdxjTxwCbTiuA32zqRRDGVqrqARXWWynuWGlLDe8gKKhFAMZYgnmj+XhpNG4DoHrhZv8LdBI84phDLEETecOMfeGRVFcLzQeXyxSDGKI5WM5WAkxcR8XMqAm29arQBFnztb5pw8v2TSLq6gEdh2ye+K42Go/fOlWJDHM7rCXLMETOKHVLLCir+2puBXpDVHQtmYtgEWJtLuHQHtkmVGZU8kokhv6CeYPoolJIwwChWfIQFHfjKM2xHNJxSe/j/k9cQy0S5wDtCsSG2IJljraDgXWhGKFzQ5fRVpDLMGSsz/nod6yJ8ch+kl3/EgNsQRLP97tOJhd/ky1RZHSENf6fJ5ffzUmXH4NwK5IaFixikqMG/me224QJHWJDbEEvZ5KiIyrct7P/IFii9QQBf2fGMRt3SrPbUKY3SI0xGOXviWYkMlMLhCvohiTGUIMXfU7FrSYveqTsSAU0zwBFcNsYl75odb0ILVjY95PsUsyPwTmu8rZk51F17Ux76kYgksEkxZd/rEiI+GezBMUbjsXsfV4NKwOxYsFKXCfA/wFgiEV55d0EZSEUryREjyRf1qTRPBWSvBECMWbEgyh2HGvh10f6ueBO7dVgidoFTvFT1Ren1VxvssL3loVFdApvtxiCZ6gUuxc+nVV4SBSvF1Bov1D59OddUMy0WDDWmFDNmTD+mFDNmTD+iFZk/r9hvO6LVzQbGPcziJiHpqv3zOc+7wVHotzX4YbrqZUX6xP+Y3epNB9j3BM8HXQ9Hy0inNenu5ws9lMNGY5FmfGZ4Ya7YQ7Qfq/ONQ/6Xg4/feOdtt80/m2+4fkxh7Zf35gGIZhGIZhGIZhGIZhGIZhGIZhGIZhGIZhGIZhGIZhGIZhGIZhfhn/AyC7g29a8/IhAAAAAElFTkSuQmCC" alt="">
                    <.link href={"/emails"}>
                      <h3 class="text-base font-semibold leading-7 tracking-tight text-indigo-600">Emails</h3>
                    </.link>
                  </div>
                </li>

                  <!-- More people... -->
                </ul>
              </div>
            </div>

              </div>
            </main>
        </div>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    # IO.puts(socket.assigns.current_user)
    {:ok,
    socket
    |> assign(:current_user, socket.assigns.current_user)}
  end
end
