defmodule NotifyWeb.Router do
  use NotifyWeb, :router

  import NotifyWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {NotifyWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NotifyWeb do
    pipe_through :browser

    live "/", LandingLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", NotifyWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:notify, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: NotifyWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", NotifyWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{NotifyWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", NotifyWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{NotifyWeb.UserAuth, :ensure_authenticated}] do
      live "/main", MainDashLive



      # Define routes for ContactLive
      live "/groups", GroupLive.Index, :index
      live "/groups/new", GroupLive.Index, :new
      live "/groups/:id/edit", GroupLive.Index, :edit

      live "/groups/:id", GroupLive.Show, :show
      live "/groups/:id/show/edit", GroupLive.Show, :edit
      # Define routes for ContactLive
      live "/contacts", ContactLive.Index, :index
      live "/contacts/new", ContactLive.Index, :new
      live "/contacts/:id/edit", ContactLive.Index, :edit

      live "/contacts/:id", ContactLive.Show, :show
      live "/contacts/:id/show/edit", ContactLive.Show, :edit

      # Define routes for ContactLive
      live "/emails", EmailLive.Index, :index
      live "/emails/new", EmailLive.Index, :new
      live "/emails/:id/edit", EmailLive.Index, :edit

      live "/emails/:id", EmailLive.Show, :show
      live "/emails/:id/show/edit", EmailLive.Show, :edit


      live "/users", UserLive.Index , :index
      live "/users/:id/edit", UserLive.Index, :edit
      # live "/users/:id", UserLive.Show, :edit
      live "/users/:id", UserLive.Show, :show
      live "/users/:id/show/edit", UserLive.Show, :edit

      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/", NotifyWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{NotifyWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
