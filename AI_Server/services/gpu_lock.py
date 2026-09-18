import threading

# There is a single 8 GB GPU serving both the image pipeline (TranslateGemma
# + SDXL) and the video pipeline (LTX-Video + optional MMAudio). The models
# cannot coexist in VRAM, so every GPU-touching stage must hold this lock.
# It replaces the private lock that used to live in the generation endpoint.
gpu_lock = threading.Lock()
