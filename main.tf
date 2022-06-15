resource "google_storage_bucket" "GCs1" { #Criando um bucket para servir de armazenamento (onde iremos subir os arquivos)
  name = "tf-curso-bucket-do-terraform"
  storage_class = "NEARLINE"

  labels = {
    "env" = "tf_env"
    "dep" = "complience"
  }

  uniform_bucket_level_access = true

  lifecycle_rule {
    condition{
      age = 5
    }
    action{
      type = "SetStorageClass"
      storage_class = "COLDLINE"
    }
  }

  retention_policy {
    is_locked = true
    retention_period = 864000  # período de tempo em segundos em que o objeto vai ser mantido sem poder ser apagado
  }

}

resource "google_storage_bucket_object" "picture" { # Subindo o objeto para o bucket criado
  name = "pi.png"
  bucket = google_storage_bucket.GCs1.name
  source = "pi.png"
}

//Dados como a location e projeto estão sendo pegos do arquivo provider.tf que está no mesmo diretório
