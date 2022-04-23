using PhotoMosaicV2;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}


app.MapGet("/", () =>
{
    
    return "Test You can see me!!!";
});

app.MapGet("/Test", () =>
{
    return "Can you see this?";
});

app.MapGet("/Hello", () =>
{
    var hello = new Hello();
    return hello.GetMessage();
});

app.Run();
