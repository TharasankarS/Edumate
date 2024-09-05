from stability_sdk.client import generation
from stability_sdk import client
from PIL import Image
from IPython.display import display
import warnings
import io
import getpass

# NB: host url is not prepended with \"https\" nor does it have a trailing slash.
STABILITY_HOST = 'grpc.stability.ai:443'

# To get your API key, visit https://beta.dreamstudio.ai/membership

stability_api = client.StabilityInference(
    host=STABILITY_HOST,
    key="sk-R8tBBJGW3uFEYOlPPXupPEVJknwXI7jGseUfwGWdkfQ0KWRA",
    verbose=True,
)
answers = stability_api.generate(
    prompt="rocket ship launching from forest with flower garden under a blue sky, masterful, ghibli",
    seed=121245125,  # if provided, specifying a random seed makes results deterministic
    steps=50,  # defaults to 30 if not specified
)

# iterating over the generator produces the api response
for resp in answers:
    for artifact in resp.artifacts:
        if artifact.finish_reason == generation.FILTER:
            warnings.warn(
                "Your request activated the API's safety filters and could not be processed."
                "Please modify the prompt and try again.")
        if artifact.type == generation.ARTIFACT_IMAGE:
            img = Image.open(io.BytesIO(artifact.binary))
            display(img)
            img.save("smth.jpg")
