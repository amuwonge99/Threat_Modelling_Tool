import express from "express";

const app = express();

const apiKey = process.env.API_KEY;

if (!apiKey) {
  throw new Error("API_KEY environment variable missing");
}

const PORT = process.env.PORT || 3000;

app.get("/health", (_req, res) => {
  res.status(200).json({
    status: "ok"
  });
});

app.get("/", (_req, res) => {
  res.json({
    message: "Threat Modelling Tool API"
  });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});